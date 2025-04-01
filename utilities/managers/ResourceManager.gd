class_name ResourceManager
extends Node

## Resource Management System for Idle Paws
## Handles resource collection, storage, and production


# player energy
var player_energy = 70
var max_player_energy = 100
var player_energy_regen_rate = 60  # Per minute

# Resource Storage
var resources: Dictionary = {}

var resource_automation_enabled = false  # Starts disabled
# Resource Storage Limits
var storage_limits: Dictionary = {}

# Resource Production Rates
var production_rates: Dictionary = {}

# Initial Resource Configuration
func _ready() -> void:
	_initialize_resources()

func _initialize_resources() -> void:
	# Initialize resources with zero amounts
	for resource_type in ItemDefinitions.ResourceType.values():
		resources[resource_type] = 0.0
		
		# Set initial storage limits from definitions
		var resource_info = ItemDefinitions.get_resource_info(resource_type)
		storage_limits[resource_type] = resource_info.get("base_storage_limit", 100.0)
		
		# Set initial production rates from definitions
		production_rates[resource_type] = resource_info.get("base_production_rate", 0.0)


signal player_energy_changed(current, maximum)
signal resource_changed(resource_type, amount, capacity)

func use_player_energy(amount):
	if player_energy < amount:
		return false
		
	player_energy -= amount
	emit_signal("player_energy_changed", player_energy, max_player_energy)
	return true

func regenerate_player_energy(delta):
	var regen_amount = (player_energy_regen_rate / 60.0) * delta
	player_energy = min(player_energy + regen_amount, max_player_energy)
	emit_signal("player_energy_changed", player_energy, max_player_energy)


## Update method called periodically by game state
func update(delta: float) -> void:
	_update_resource_production(delta)
	_check_resource_caps()
	regenerate_player_energy(delta)

## Produce resources based on current production rates and buildings
func _update_resource_production(delta: float) -> void:
	# Skip automatic production if automation is not enabled
	if not resource_automation_enabled:
		return
	
	for resource_type in production_rates:
		var production_amount = production_rates[resource_type] * delta
		add_resource(resource_type, production_amount)

## Ensure resources don't exceed storage limits
func _check_resource_caps() -> void:
	for resource_type in resources:
		resources[resource_type] = min(
			resources[resource_type], 
			storage_limits.get(resource_type, 100.0)
		)

## Add a specific amount of a resource
func add_resource(resource_name_or_type, amount: float) -> void:
	var resource_type = resource_name_or_type
	print("Adding resource: Type=", resource_type, " Amount=", amount)
	
	print("Adding resource: Type=", resource_type, " Amount=", amount)
	# Convert string to enum if needed
	if typeof(resource_name_or_type) == TYPE_STRING:
		# Find the enum value for this resource name
		for type in ItemDefinitions.ResourceType.values():
			if ItemDefinitions.get_resource_info(type).get("name", "").to_lower() == resource_name_or_type.to_lower():
				resource_type = type
				break
	
	if not resources.has(resource_type):
		push_error("Invalid resource type: " + str(resource_type))
		return
	# Debugging - show current amount before adding
	print("Before adding: ", resources[resource_type])
	
	resources[resource_type] += amount
	emit_signal("resource_changed", resource_type, resources[resource_type], storage_limits[resource_type])
   # Debugging - show new amount after adding
	print("After adding: ", resources[resource_type])
	_check_resource_caps()
	# Add more debugging to see if caps are being applied
	print("After cap check: ", resources[resource_type])
## Remove a specific amount of a resource
func remove_resource(resource_type: int, amount: float) -> bool:
	if not resources.has(resource_type):
		push_error("Invalid resource type: " + str(resource_type))
		return false
	
	if resources[resource_type] < amount:
		return false
	
	resources[resource_type] -= amount
	return true

## Check current amount of a resource
func get_resource_amount(resource_type: int) -> float:
	return resources.get(resource_type, 0.0)

## Get resource metadata (from definitions)
func get_resource_metadata(resource_type: int) -> Dictionary:
	return ItemDefinitions.get_resource_info(resource_type)

## Increase storage limit for a resource
func upgrade_storage_limit(resource_type: int, new_limit: float) -> void:
	if not storage_limits.has(resource_type):
		push_error("Invalid resource type for storage upgrade: " + str(resource_type))
		return
	
	storage_limits[resource_type] = new_limit

## Modify production rate for a resource
func set_production_rate(resource_type: int, rate: float) -> void:
	if not production_rates.has(resource_type):
		push_error("Invalid resource type for production rate: " + str(resource_type))
		return
	
	production_rates[resource_type] = rate

## Get save data for game state
func get_save_data() -> Dictionary:
	var save_data= {
		"resources": resources,
		"storage_limits": storage_limits,
		"production_rates": production_rates
	}
	return save_data
	print("ResourceManager: Saving data:", save_data)
## Load save data
func load_save_data(data: Dictionary) -> void:
	print("ResourceManager: Loading data:", data)
	if data.has("resources"):
		resources = data["resources"]
	
	if data.has("storage_limits"):
		storage_limits = data["storage_limits"]
	
	if data.has("production_rates"):
		production_rates = data["production_rates"]

## Check if player has enough resources for a cost
func can_afford(resource_costs: Dictionary) -> bool:
	for resource_type in resource_costs:
		if get_resource_amount(resource_type) < resource_costs[resource_type]:
			return false
	return true

## Spend resources for a purchase or action
func spend_resources(resource_costs: Dictionary) -> bool:
	# First check if can afford
	if not can_afford(resource_costs):
		return false
	
	# Remove resources
	for resource_type in resource_costs:
		remove_resource(resource_type, resource_costs[resource_type])
	
	return true

## Filter resources (delegates to ItemDefinitions)
func filter_resources(filter_criteria: Dictionary) -> Array:
	return ItemDefinitions.filter_resources(filter_criteria)
func enable_automation() -> void:
	resource_automation_enabled = true
	print("Resource automation enabled!")
	
func disable_automation() -> void:
	resource_automation_enabled = false
	print("Resource automation disabled!")
