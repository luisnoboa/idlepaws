# ResourceGatheringScene.gd
extends Control

@onready var locations_container = %VBoxMainLocationContainer

func _ready():
	# Populate the locations from your game data
	populate_locations()
	
	#update_energy_display()
  	# Connect to energy change signal from ResourceManager
	GameState.resources.player_energy_changed.connect(update_energy_display)
func populate_locations():
	# Clear existing locations
	for child in locations_container.get_children():
		child.queue_free()
		
	# Get locations data (from your game state or resource manager)
	var locations_data = GameState.exploration.get_exploration_locations()
	
	# Add each location
	for location_data in locations_data:
		add_location(location_data)

func add_location(location_data):
	var location_container = preload("res://scenes/gathering/location_container.tscn").instantiate()
	location_container.location_name = location_data.name
	
	# Use the get_info_text() method instead of accessing a non-existent 'info' property
	location_container.location_info = location_data.get_info_text()
	
	location_container.is_home = location_data.is_home
	location_container.location_id = location_data.id
	
	# Add the location to the container
	locations_container.add_child(location_container)
	
	# Connect location container signel
	location_container.location_selected.connect(_on_location_selected)
  
	
	# Populate with gathering spots
	for spot_data in location_data.spots:
		var spot_card = preload("res://scenes/gathering/spot_card.tscn").instantiate()
		spot_card.spot_name = spot_data.name
		spot_card.spot_yields = spot_data.get_yields_text()
		spot_card.energy_cost = spot_data.energy_cost
		spot_card.is_locked = spot_data.is_locked
		spot_card.spot_id = spot_data.id
		var unlock_cost_text = ""
		for resource_type in spot_data.unlock_costs:
			if unlock_cost_text != "":
				unlock_cost_text += ", "
			var resource_name = ItemDefinitions.get_resource_info(resource_type).get("name", "Unknown")
			unlock_cost_text += str(spot_data.unlock_costs[resource_type]) + " " + resource_name
		# Connect signals using Godot 4 syntax
		spot_card.gather_pressed.connect(_on_gather_pressed)
		spot_card.unlock_pressed.connect(_on_unlock_pressed)
		
		# Add to location container
		location_container.add_spot_card(spot_card)
		
	return location_container

# Define the signal handlers that were missing
func _on_location_selected(location_id):
	# Handle location selection here
	print("Location selected: " + location_id)
	
	# You might want to do something like:
	# - Update the right panel with location details
	# - Toggle expanded state of other locations
	# - Update the selected location in GameState

func _on_gather_pressed(spot_id,button):
	# Disable the button while gathering
	button.disabled = true
	# Get references to your UI elements
	var progress_bar = %GatheringProgressBar
	var timer_label = %GatheringTimeRemaning
	var energy_label =  %GatheringEnergyRequirements
	var spot = GameState.exploration.get_gathering_spot_by_id(spot_id)
	
	 # Start a timer to update the progress bar
	var gathering_time = spot.gathering_time
	var start_time = Time.get_ticks_msec() / 1000.0
	
	# This creates a timer that ticks every frame to update the progress
	while (Time.get_ticks_msec() / 1000.0) - start_time < gathering_time:
		var elapsed = (Time.get_ticks_msec() / 1000.0) - start_time
		var progress = (elapsed / gathering_time) * 100
		progress_bar.value = progress
		
		# Update the timer label
		var time_left = gathering_time - elapsed
		timer_label.text = str(snapped(time_left, 0.1)) + "s remaining"
		
		# Wait for the next frame
		await get_tree().process_frame
	
		
	# Gathering complete, get results
	var results = await GameState.exploration.gather_from_spot(spot_id)
	print("Gather results received:", results)
	  # Update UI with results
	if results:
		# Show gathering results to the player
		print("Gathered: ", results)
		display_gathering_results(results)
		# ADD THIS LINE HERE - Update resource displays
		update_resource_displays() 
	# Reset UI
	progress_bar.value = 100
	timer_label.text = "Complete!"
	
	# Re-enable the button
	button.disabled = false
func _on_unlock_pressed(spot_id):
	# Implement unlock logic
	print("Unlocking spot: " + spot_id)
	# Call your unlock function through the exploration manager
	var success = GameState.exploration.unlock_gathering_spot(spot_id)
	if success:
		# Update UI to show spot is now unlocked
		print("Successfully unlocked spot!")
		# Refresh the locations display
		populate_locations()
func update_selected_spot_ui(spot):
	# Update the right panel to show details about the selected spot
	var title_label = $ContentPanel/MarginContainer/MainLayoutContainer/RightContentMargin/MarginContainer/VBoxContainer/GatheringSpotPanel2/GSpotVBoxContainer/GSpotName
	var energy_label = %GatheringEnergyRequirements
	var yields_label = $ContentPanel/MarginContainer/MainLayoutContainer/RightContentMargin/MarginContainer/VBoxContainer/GatheringSpotPanel/VBoxContainer/GatheringSpotsYieldLabel
	
	title_label.text = spot.name
	energy_label.text = "Energy: " + str(spot.energy_cost)
	yields_label.text = spot.get_yields_text()
	
	# You could also update other UI elements like:
	# - Spot image
	# - Description
	# - Bonuses that apply to this spot

# In ResourceGatheringScene.gd
func display_gathering_results(results):
	# Update your UI to show what was gathered
	var results_container = %gatheringResultsContainer
	print("Display results called with:", results)
	# Clear previous results
	for child in results_container.get_children():
		child.queue_free()
	
	# Create labels for each resource gathered
	for resource_type in results:
		var resource_info = ItemDefinitions.get_resource_info(resource_type)
		var resource_name = resource_info.get("name", "Unknown")
		print("resource name is "+resource_name)
		var amount = results[resource_type]
		print("Amount is ")
		
		
		var result_label = Label.new()
		result_label.text = resource_name + ": " + str(amount)
			 # Create a HBoxContainer for this resource result
		var result_row = HBoxContainer.new()
		# Get current inventory amount and capacity
		var current_amount = GameState.resources.get_resource_amount(resource_type)
		var storage_limit = resource_info.get("base_storage_limit", 100.0)
		print("When displaying results, resource ", resource_type, " amount: ", current_amount)
		# Add gained amount with "+" prefix
		var gained_label = Label.new()
		gained_label.text = "+" + str(amount) + " " + resource_name
		gained_label.add_theme_color_override("font_color", Color(0.2, 0.8, 0.2))  # Green color
		result_row.add_child(gained_label)
		
		# Add spacer
		var spacer = Control.new()
		spacer.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		result_row.add_child(spacer)
		
		# Add inventory status
		var inventory_label = Label.new()
		inventory_label.text = str(current_amount) + "/" + str(storage_limit)
		
		# Color code based on how full storage is
		var fill_percentage = float(current_amount) / storage_limit
		if fill_percentage > 0.9:
			inventory_label.add_theme_color_override("font_color", Color(0.8, 0.2, 0.2))  # Red when almost full
		elif fill_percentage > 0.7:
			inventory_label.add_theme_color_override("font_color", Color(0.8, 0.8, 0.2))  # Yellow when getting full
		
		result_row.add_child(inventory_label)
		
		# Add the row to the results container
		results_container.add_child(result_row)
		
		
		# Optional: Add color coding based on rarity or resource type
		if resource_info.get("rarity") == "Rare":
			result_label.add_theme_color_override("font_color", Color(0.9, 0.6, 0.1))
		
		results_container.add_child(result_label)
	
	# Play a sound effect
	var audio_player = $GatheringSound
	if audio_player:
		audio_player.play()
	
	# Maybe show particles or other visual effects
	var particles = $GatheringParticles
	if particles:
		particles.emitting = true
func update_energy_display(current, maximum):
	# Assuming you have a progress bar for energy in your scene
	var energy_bar = %PlayerEnergyAvialableGath
	var energy_label = $ContentPanel/MarginContainer/MainLayoutContainer/RightContentMargin/MarginContainer/VBoxContainer/GatheringSpotPanel2/GSpotVBoxContainer/PlayerEnergyAvialableGath/PlayerEnergyAvialableGathLabel
	
	# Update the progress bar
	energy_bar.value = current
	energy_bar.max_value = maximum
	
	# Update the label with current/max energy
	energy_label.text = str(current) + "/" + str(maximum)
func update_resource_displays():
	# Update any resource display elements in your UI
	for resource_type in ItemDefinitions.ResourceType.values():
		var current_amount = GameState.resources.get_resource_amount(resource_type)
		var storage_limit = GameState.resources.storage_limits.get(resource_type, 100.0)
		
		# Find and update the corresponding UI element
		var resource_label = $ContentPanel/MarginContainer/MainLayoutContainer/RightContentMargin/MarginContainer/VBoxContainer/GatheringSpotPanel/VBoxContainer2/gatheringResultsContainer/GatheringSpot1/HBoxContainer/GatherintSpotLabel1
		if resource_label:
			resource_label.text = str(current_amount) + "/" + str(storage_limit)
			
	# Also update the specific resource info in the right panel if a spot is selected
	#update_selected_spot_ui(GameState.exploration.get_gathering_spot_by_id(spot_id))
