# CatDefinitions.gd
class_name CatDefinitions

## Static cat breed metadata and definitions

static func get_cat_breed_metadata() -> Dictionary:
	return {
		CatBreed.TABBY: {
			"name": "Tabby",
			"description": "Agile and resourceful, excellent at exploration",
			"attributes": {
				"strength": 6,
				"agility": 8, 
				"intelligence": 5,
				"charisma": 6,
				"luck": 5,
				"resilience": 2
			},
			"specialization": "Explorer",
			"special_trait": "Pathfinder",
			"special_trait_description": "15% faster exploration speed"
		},
		CatBreed.SIAMESE: {
			"name": "Siamese",
			"description": "Intelligent and methodical, excellent at crafting",
			"attributes": {
				"strength": 4,
				"agility": 6,
				"intelligence": 9,
				"charisma": 7,
				"luck": 4,
				"resilience": 2
			},
			"specialization": "Crafter",
			"special_trait": "Inventor",
			"special_trait_description": "10% chance to discover new recipes"
		},
		CatBreed.CALICO: {
			"name": "Calico",
			"description": "Strong and lucky, excellent at resource gathering",
			"attributes": {
				"strength": 7,
				"agility": 5,
				"intelligence": 6,
				"charisma": 5,
				"luck": 7,
				"resilience": 2
			},
			"specialization": "Gatherer",
			"special_trait": "Resource Sense",
			"special_trait_description": "15% bonus to resource yield"
		}
	}

## Cat Breed Enum
enum CatBreed {
	TABBY,
	SIAMESE,
	CALICO
}

## Get metadata for a specific cat breed
static func get_cat_breed_info(breed: int) -> Dictionary:
	var metadata = get_cat_breed_metadata()
	return metadata.get(breed, {})

## Filter cats based on criteria
static func filter_cat_breeds(filter_criteria: Dictionary) -> Array:
	var matching_breeds = []
	var metadata = get_cat_breed_metadata()
	
	for breed in metadata:
		var breed_info = metadata[breed]
		var matches = true
		
		# Check each filter criterion
		for key in filter_criteria:
			if not breed_info.has(key) or breed_info[key] != filter_criteria[key]:
				matches = false
				break
		
		if matches:
			matching_breeds.append({
				"breed": breed,
				"metadata": breed_info
			})
	
	return matching_breeds
