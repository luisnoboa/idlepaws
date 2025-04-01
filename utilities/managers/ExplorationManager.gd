# ExplorationManager.gd
class_name ExplorationManager
extends Node

# Reference to other managers
var resources: ResourceManager

# Storage for locations data
var locations = []
var current_home_location_id = "garden_area"

# Class for resource yield information
class ResourceYield:
	var resource_type: int  # From ResourceType enum
	var min_amount: float
	var max_amount: float
	var chance: float = 1.0  # 1.0 = 100%, 0.1 = 10% chance
	
	func _init(p_type: int, p_min: float, p_max: float, p_chance: float = 1.0):
		resource_type = p_type
		min_amount = p_min
		max_amount = p_max
		chance = p_chance

# Class for gathering spot data
class GatheringSpot:
	var id: String
	var name: String
	var description: String
	var energy_cost: int
	var gathering_time: float  # in seconds
	var yields: Array  # Array of ResourceYield objects
	var is_locked: bool = true
	var unlock_costs: Dictionary  # Resource type -> amount
	var required_tools: Array  # Optional tool IDs for increased efficiency
	var required_level: int = 1  # Level required to use this spot
	var thumbnail_image: String  # Path to thumbnail image
	
	func get_yields_text() -> String:
		var result = "Yields: "
		for i in range(yields.size()):
			var yield_info = yields[i]
			var resource_name = ItemDefinitions.get_resource_info(yield_info.resource_type).get("name", "Unknown")
			var chance_text = ""
			if yield_info.chance < 1.0:
				chance_text = " (" + str(int(yield_info.chance * 100)) + "% chance)"
			
			result += resource_name + " (" + str(yield_info.min_amount) + "-" + str(yield_info.max_amount) + ")" + chance_text
			if i < yields.size() - 1:
				result += ", "
		return result
		
	func can_unlock(available_resources: Dictionary) -> bool:
		for resource_type in unlock_costs:
			if not available_resources.has(resource_type) or available_resources[resource_type] < unlock_costs[resource_type]:
				return false
		return true

# Class for location data
class Location:
	var id: String
	var name: String
	var description: String
	var is_unlocked: bool = false
	var is_home: bool = false
	var proximity_bonus: Dictionary  # Resource type -> bonus percentage
	var travel_time: int = 0  # in minutes
	var thumbnail_image: String  # Path to thumbnail image
	var spots: Array  # Array of GatheringSpot objects
	var required_level: int = 1  # Level required to unlock this location
	
	func get_info_text() -> String:
		if is_home:
			var bonus_text = ""
			for resource in proximity_bonus:
				if bonus_text != "":
					bonus_text += ", "
				var resource_name = ItemDefinitions.get_resource_info(resource).get("name", "Unknown")
				bonus_text += "+" + str(proximity_bonus[resource]) + "% " + resource_name
			
			return bonus_text if bonus_text != "" else "Home Location"
		else:
			return str(travel_time) + " minute travel time"
			
	func get_unlocked_spots() -> Array:
		var result = []
		for spot in spots:
			if !spot.is_locked:
				result.append(spot)
		return result

func _ready():
	# Get reference to other managers
	resources = get_parent().resources
	print("Resource manager reference:", resources)
	print("Resource manager class:", resources.get_class())
	 # Test a method call directly
	var test_resource = 0  # Catnip
	var test_amount = 10.0
	print("Testing direct add_resource call with", test_amount, "resources")
	resources.add_resource(test_resource, test_amount)
	
	
	
	# Initialize locations
	initialize_locations()
	
	# Set initial home
	set_home_location(current_home_location_id)

# Initialize all game locations and gathering spots using definitions
func initialize_locations():
	locations = []
	
	# Load all location definitions
	var location_defs = LocationDefinitions.get_location_definitions()
	var spot_defs = LocationDefinitions.get_gathering_spot_definitions()
	
	# Create location objects
	for loc_id in location_defs:
		var loc_def = location_defs[loc_id]
		
		var location = Location.new()
		location.id = loc_id
		location.name = loc_def.name
		location.description = loc_def.description
		location.is_unlocked = loc_def.is_unlocked
		location.required_level = loc_def.required_level
		location.thumbnail_image = loc_def.thumbnail_image
		location.proximity_bonus = loc_def.proximity_bonus
		location.travel_time = loc_def.travel_time
		
		# Create gathering spots for this location
		var spots = []
		for spot_id in loc_def.spots:
			if spot_defs.has(spot_id):
				var spot_def = spot_defs[spot_id]
				
				var spot = GatheringSpot.new()
				spot.id = spot_id
				spot.name = spot_def.name
				spot.description = spot_def.description
				spot.energy_cost = spot_def.energy_cost
				spot.gathering_time = spot_def.gathering_time
				spot.is_locked = spot_def.is_locked
				spot.unlock_costs = spot_def.unlock_costs
				spot.thumbnail_image = spot_def.thumbnail_image
				spot.required_level = spot_def.required_level
				spot.required_tools = spot_def.required_tools
				
				# Create resource yields
				var yields = []
				for yield_def in spot_def.yields:
					yields.append(ResourceYield.new(
						yield_def.resource_type,
						yield_def.min_amount,
						yield_def.max_amount,
						yield_def.chance
					))
				spot.yields = yields
				
				spots.append(spot)
		
		location.spots = spots
		locations.append(location)

# Set a location as the home base
func set_home_location(location_id):
	for location in locations:
		location.is_home = (location.id == location_id)
	
	current_home_location_id = location_id

# Get all locations data for UI
func get_exploration_locations():
	return locations

# Get a specific location by ID
func get_location_by_id(location_id):
	for location in locations:
		if location.id == location_id:
			return location
	return null

# Get a specific gathering spot by ID
func get_gathering_spot_by_id(spot_id):
	for location in locations:
		for spot in location.spots:
			if spot.id == spot_id:
				return spot
	return null

# Unlock a gathering spot
func unlock_gathering_spot(spot_id):
	var spot = get_gathering_spot_by_id(spot_id)
	if spot and spot.can_unlock(resources.resources):
		# Spend the resources
		for resource_type in spot.unlock_costs:
			resources.remove_resource(resource_type, spot.unlock_costs[resource_type])
		
		# Unlock the spot
		spot.is_locked = false
		return true
	return false

# Gather resources from a spot
func gather_from_spot(spot_id):
	var spot = get_gathering_spot_by_id(spot_id)
	if spot == null:
		print("ERROR: Gathering spot not found: " + spot_id)
		return null
	if spot.is_locked:
		print("ERROR: Attempting to gather from locked spot: " + spot_id)
		return null
		
			# Check if player has enough energy
	if resources.use_player_energy(spot.energy_cost):
		var timer = get_tree().create_timer(spot.gathering_time)
		await timer.timeout
		# Calculate bonuses
		var location = get_location_for_spot(spot_id)
		var bonus_multiplier = 1.0
		
		# Apply home location bonus if applicable
		if location and location.is_home:
			for resource_type in location.proximity_bonus:
				bonus_multiplier += location.proximity_bonus[resource_type] / 100.0
		
		# Apply other bonuses here (equipment, skills, etc.)
		# Add this before calculating the amount
		
		# Generate yields with randomization and bonuses
		var results = {}
		for yield_info in spot.yields:
			print("Yield info:", yield_info.resource_type, 
			  "min:", yield_info.min_amount, "max:", yield_info.max_amount,
			  "type min:", typeof(yield_info.min_amount), "type max:", typeof(yield_info.max_amount))
			print("Bonus multiplier:", bonus_multiplier)
			
			
			if randf() <= yield_info.chance:
				var amount = round(randf_range(yield_info.min_amount, yield_info.max_amount) * bonus_multiplier)
				if amount > 0:
					print("ABOUT TO ADD RESOURCE: type=", yield_info.resource_type, " amount=", amount)
					print("Resources object ID before call:", resources.get_instance_id())
					
					print("FINAL AMOUNT IN GATHER_FROM_SPOT:", amount)
					print("CALLING ADD_RESOURCE DIRECTLY")
					
					resources.add_resource(yield_info.resource_type, amount)
					results[yield_info.resource_type] = amount
					# Then after calculating the amount
					print("Calculated amount before rounding:", randf_range(yield_info.min_amount, yield_info.max_amount) * bonus_multiplier)
					print("Final amount after rounding:", amount)
					print("Adding to results: resource_type=", yield_info.resource_type, " amount=", amount)
					results[yield_info.resource_type] = amount
		return results

	
	return null

# Helper to find which location a spot belongs to
func get_location_for_spot(spot_id):
	for location in locations:
		for spot in location.spots:
			if spot.id == spot_id:
				return location
	return null

# Get save data for game state
func get_save_data() -> Dictionary:
	var locations_data = []
	for location in locations:
		var spots_data = []
		for spot in location.spots:
			spots_data.append({
				"id": spot.id,
				"is_locked": spot.is_locked
			})
		
		locations_data.append({
			"id": location.id,
			"is_unlocked": location.is_unlocked,
			"spots": spots_data
		})
	
	return {
		"locations": locations_data,
		"home_location_id": current_home_location_id
	}

# Load save data
func load_save_data(data: Dictionary) -> void:
	if data.has("home_location_id"):
		current_home_location_id = data["home_location_id"]
		set_home_location(current_home_location_id)
	
	if data.has("locations"):
		for loc_data in data["locations"]:
			var location = get_location_by_id(loc_data["id"])
			if location:
				location.is_unlocked = loc_data["is_unlocked"]
				
				if loc_data.has("spots"):
					for spot_data in loc_data["spots"]:
						for spot in location.spots:
							if spot.id == spot_data["id"]:
								spot.is_locked = spot_data["is_locked"]
