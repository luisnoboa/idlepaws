# LocationContainer.gd
extends VBoxContainer

signal location_selected(location_id)

@export var location_name = "Location Name"
@export var location_info = "Info text"
@export var is_home = false
@export var is_expanded = false
@export var location_id = ""

@onready var header_button = $HeaderButton
@onready var name_label = $HeaderButton/HBoxContainer/NameLabel
@onready var info_label = $HeaderButton/HBoxContainer/InfoLabel
@onready var arrow_indicator = $HeaderButton/HBoxContainer/ArrowIndicator
@onready var cards_container = $SpotsContainer

func _ready():
	# Setup the header appearance
	name_label.text = location_name
	info_label.text = location_info
	
	# Set home location styling if applicable
	if is_home:
		var style = StyleBoxFlat.new()
		style.bg_color = Color("#81C784")
		style.corner_radius_top_left = 5
		style.corner_radius_top_right = 5
		style.corner_radius_bottom_left = 5
		style.corner_radius_bottom_right = 5
		
		
		
		# Apply the style to the button
		header_button.add_theme_stylebox_override("normal", style)
		name_label.text = location_name + " (Home)"
	# Initialize expanded/collapsed state
	set_expanded(is_expanded)
	
	# Connect signal
	header_button.pressed.connect(_on_header_pressed)

# Toggle expansion when header is pressed
func _on_header_pressed():
	set_expanded(!is_expanded)
	location_selected.emit(location_id)

# Set the expanded/collapsed state
func set_expanded(expanded):
	is_expanded = expanded
	cards_container.visible = expanded
	arrow_indicator.text = "▼" if expanded else "▶"
	if is_inside_tree():
	# This forces the parent VBoxContainer to recalculate layout
		get_parent().queue_sort()
# Add a gathering spot card
func add_spot_card(spot_scene_instance):
	cards_container.add_child(spot_scene_instance)
