# home_scene.gd
extends Control

# References to UI elements
var energy_bar
var energy_label
var energy_regen
var stat_bars = {}
@onready var stat_labels = {
	"Strength": %StrengthLabel,
	"Agility": %AgilityLabel,
	"Intelligence": %IntelligenceLabel,
	"Charisma": %CharismaLabel,
	"Luck": %LuckLabel
}
func _ready():
	# Get references to energy UI elements
	energy_bar = $ContentPanel/MarginContainer/MainLayoutContainer/LeftContent/LeftPanels/PlayerPanelMargins/PlayerScreen/VBoxContainer/Energy/VBoxContainer/HBoxContainer/EnergyProgressBar
	energy_label = $ContentPanel/MarginContainer/MainLayoutContainer/LeftContent/LeftPanels/PlayerPanelMargins/PlayerScreen/VBoxContainer/Energy/VBoxContainer/HBoxContainer/EnergyProgressBar/EnergyProBarLabel
	energy_regen= $ContentPanel/MarginContainer/MainLayoutContainer/LeftContent/LeftPanels/PlayerPanelMargins/PlayerScreen/VBoxContainer/Energy/VBoxContainer/Recharge
	# Connect to the energy_changed signal
	GameState.resources.connect("player_energy_changed", _on_player_energy_changed)
	
	# Initialize the energy display
	update_cat_energy_displays()
 
	

	update_stat_displays()
	# Connect to signals
	GameState.cats.connect("cat_updated", _on_cat_updated)

func _on_player_energy_changed(current, maximum):
	update_energy_display()

func update_energy_display():
	if energy_bar:
		energy_bar.value = GameState.resources.player_energy
		energy_bar.max_value = GameState.resources.max_player_energy
	
	if energy_regen:
		energy_regen.text = "Recharging: +" + str(GameState.resources.player_energy_regen_rate) + "/min"
	
	#update energy indicator label
	if energy_label:
		energy_label.text = str(energy_bar.value) + " / " + str(energy_bar.max_value)



func update_cat_energy_displays():
	# This would update any UI elements showing individual cat energy
	# You might implement this in a different scene dedicated to cat management
	pass
func update_stat_displays():
	var player_cat = GameState.cats.get_player_cat()
	if not player_cat:
		return
	
	# Update player name and level
	var player_name_label = $ContentPanel/MarginContainer/MainLayoutContainer/LeftContent/LeftPanels/PlayerPanelMargins/PlayerScreen/VBoxContainer/HBoxContainer/VBoxContainer/HomePlayerName
	if player_name_label:
		player_name_label.text = player_cat.name
	
	var player_level_label = $ContentPanel/MarginContainer/MainLayoutContainer/LeftContent/LeftPanels/PlayerPanelMargins/PlayerScreen/VBoxContainer/HBoxContainer/VBoxContainer/HomePlayerLevel
	if player_level_label:
		player_level_label.text = "Level: " + str(player_cat.level) 
	
	var player_specialization_label = $ContentPanel/MarginContainer/MainLayoutContainer/LeftContent/LeftPanels/PlayerPanelMargins/PlayerScreen/VBoxContainer/HBoxContainer/VBoxContainer/HomePlayerSpecialization
	if player_specialization_label:
		player_specialization_label.text = player_cat.specialization
		
	var player_breed_label = $ContentPanel/MarginContainer/MainLayoutContainer/LeftContent/LeftPanels/PlayerPanelMargins/PlayerScreen/VBoxContainer/HBoxContainer/VBoxContainer/HomePlayerBreed
	if player_breed_label:
		var breed_info = CatDefinitions.get_cat_breed_info(player_cat.breed)
		var breed_name = breed_info.get("name", "Unknown")
		player_breed_label.text = "Breed: " + breed_name
	
	
	
		# Update stat labels 
	update_stat_label("Strength", player_cat.attributes.get("strength", 0))
	update_stat_label("Agility", player_cat.attributes.get("agility", 0))
	update_stat_label("Intelligence", player_cat.attributes.get("intelligence", 0))
	update_stat_label("Charisma", player_cat.attributes.get("charisma", 0))
	update_stat_label("Luck", player_cat.attributes.get("luck", 0))
	
	if player_cat.attributes.has("resilience"):
		update_stat_label("Resilience", player_cat.attributes.get("resilience", 0))

func _on_cat_updated(cat_id):
	# Only update UI if it's the player cat that changed
	if cat_id == GameState.cats.player_cat_id:
		update_stat_displays()

func update_stat_label(stat_name, value):

	var stat_label = stat_labels.get(stat_name)
	
	print (stat_label)
	if stat_label:
		stat_label.text = stat_name + ": " + str(value)
