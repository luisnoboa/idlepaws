# SpotCard.gd
extends Panel

signal gather_pressed(spot_id)
signal unlock_pressed(spot_id)

@export var spot_name = "Spot Name"
@export var spot_yields = "Yields: Resource (1-2)"
@export var energy_cost = 0
@export var is_locked = false
@export var unlock_cost = ""
@export var spot_id = ""

@onready var name_label = $HBoxContainer/VBoxContainer/NameLabel
@onready var yields_label = $HBoxContainer/VBoxContainer/YieldsLabel
@onready var energy_label = $HBoxContainer/VBoxContainer/EnergyLabel
@onready var unlock_label = $HBoxContainer/VBoxContainer/UnlockLabel
@onready var action_button = $HBoxContainer/ActionButton

func _ready():
	name_label.text = spot_name
	yields_label.text = spot_yields
	energy_label.text = "Energy Cost: " + str(energy_cost)
	
	if is_locked:
		# Setup for locked spot
		set_modulate(Color(1, 1, 1, 0.7))
		unlock_label.text = "Unlock Cost: " + unlock_cost
		unlock_label.visible = true
		energy_label.visible = false
		action_button.text = "Unlock"
		action_button.pressed.connect(_on_unlock_pressed)
	else:
		# Setup for unlocked spot
		unlock_label.visible = false
		action_button.text = "Gather"
		action_button.pressed.connect(_on_gather_pressed)

func _on_gather_pressed():
	gather_pressed.emit(spot_id, action_button)

func _on_unlock_pressed():
	emit_signal("unlock_pressed", spot_id)
