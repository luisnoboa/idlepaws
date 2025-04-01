# CatManager.gd
class_name CatManager
extends Node

# Signal when a cat's data changes
signal cat_updated(cat_id)

# Cat class
class Cat:
	var id: String = ""
	var name: String = ""
	var breed: int = CatDefinitions.CatBreed.TABBY
	var level: int = 1
	var experience: int = 0
	var attributes: Dictionary = {}
	var energy: float = 50.0
	var max_energy: float = 50.0
	var energy_regen_rate: float = 0.5
	var assigned_task = null
	var loyalty: int = 50  # Hidden value determining loyalty
	var specialization: String = ""
	
	func _init(p_name: String, p_breed: int):
		name = p_name
		breed = p_breed
		id = name.to_lower().replace(" ", "_") + "_" + str(randi() % 1000)
		
		# Initialize attributes from breed definition
		var breed_info = CatDefinitions.get_cat_breed_info(breed)
		if breed_info.has("attributes"):
			attributes = breed_info.attributes.duplicate()
		
		if breed_info.has("specialization"):
			specialization = breed_info.specialization
	
	# Energy management functions
	func use_energy(amount: float) -> bool:
		if energy < amount:
			return false
		
		energy -= amount
		return true
	
	func regenerate_energy(delta: float) -> void:
		var regen_amount = (energy_regen_rate / 60.0) * delta
		energy = min(energy + regen_amount, max_energy)
	
	func get_energy_percent() -> float:
		return (energy / max_energy) * 100.0

# Cat Manager properties
var cats: Dictionary = {}  # Dictionary of all cats by ID
var player_cat_id: String = ""  # ID of the player's main cat

func _ready() -> void:
	# Initialize the player's cat
	create_player_cat("Whiskers", CatDefinitions.CatBreed.TABBY)

func create_player_cat(name: String, breed: int) -> void:
	var player_cat = Cat.new(name, breed)
	player_cat_id = player_cat.id
	cats[player_cat_id] = player_cat

func update(delta: float) -> void:
	# Update all cats
	for cat_id in cats:
		cats[cat_id].regenerate_energy(delta)
		# Process any assigned tasks...

func get_player_cat() -> Cat:
	return cats[player_cat_id]

func update_cat_attributes(cat_id: String, new_attributes: Dictionary) -> void:
	if cats.has(cat_id):
		cats[cat_id].attributes = new_attributes
		emit_signal("cat_updated", cat_id)

func get_save_data() -> Dictionary:
	var save_data = {}
	
	for cat_id in cats:
		var cat = cats[cat_id]
		save_data[cat_id] = {
			"name": cat.name,
			"breed": cat.breed,
			"level": cat.level,
			"experience": cat.experience,
			"attributes": cat.attributes,
			"energy": cat.energy,
			"max_energy": cat.max_energy,
			"energy_regen_rate": cat.energy_regen_rate,
			"loyalty": cat.loyalty,
			"specialization": cat.specialization
		}
	
	save_data["player_cat_id"] = player_cat_id
	
	return save_data

func load_save_data(data: Dictionary) -> void:
	cats.clear()
	
	# Recreate all cats from saved data
	for cat_id in data:
		if cat_id == "player_cat_id":
			continue
			
		var cat_data = data[cat_id]
		var cat = Cat.new(cat_data["name"], cat_data["breed"])
		cat.id = cat_id
		cat.level = cat_data["level"]
		cat.experience = cat_data["experience"]
		cat.attributes = cat_data["attributes"]
		cat.energy = cat_data["energy"]
		cat.max_energy = cat_data["max_energy"]
		cat.energy_regen_rate = cat_data["energy_regen_rate"]
		cat.loyalty = cat_data["loyalty"]
		cat.specialization = cat_data["specialization"]
		
		cats[cat_id] = cat

	
	if data.has("player_cat_id"):
		player_cat_id = data["player_cat_id"]
	else:
		# If not found, set to the first cat or create a new one
		if cats.size() > 0:
			player_cat_id = cats.keys()[0]
		else:
			create_player_cat("Whiskers", CatDefinitions.CatBreed.TABBY)
