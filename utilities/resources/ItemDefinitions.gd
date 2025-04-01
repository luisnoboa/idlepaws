## Resource Definitions for Idle Paws
## Centralized resource metadata and definitions

class_name ItemDefinitions

## Static resource metadata
## Can be expanded easily without modifying core systems
static func get_resource_metadata() -> Dictionary:
	return {
		# Tier 1 Resources
		ResourceType.CATNIP: {
			"name": "Catnip",
			"description": "Basic food source and primary currency",
			"tier": 1,
			"category": ["Currency, Food"],
			"rarity": "Common",
			"tags": ["edible", "currency"],
			"base_storage_limit": 50.0,
			"base_production_rate": 0.1
		},
		ResourceType.TWIGS: {
			"name": "Twigs",
			"description": "Small branches useful for crafting and building",
			"tier": 1,
			"category": "Crafting Material",
			"rarity": "Common",
			"tags": ["construction", "gatherable"],
			"base_storage_limit": 30.0,
			"base_production_rate": 0.05
		},
		ResourceType.LEAVES: {
			"name": "Leaves",
			"description": "Fallen leaves from trees, useful for various purposes",
			"tier": 1,
			"category": "Natural Material",
			"rarity": "Common", 
			"tags": ["organic", "gatherable"],
			"base_storage_limit": 40.0,
			"base_production_rate": 0.07
		},
		ResourceType.MOSS: {
			"name": "Moss",
			"description": "Soft, damp plant growth found in shaded areas",
			"tier": 1,
			"category": "Natural Material",
			"rarity": "Uncommon",
			"tags": ["organic", "rare"],
			"base_storage_limit": 20.0,
			"base_production_rate": 0.02
		},
		ResourceType.SPIDER_SILK: {
			"name": "Spider Silk",
			"description": "Soft, damp plant growth found in shaded areas",
			"tier": 1,
			"category": "Natural Material",
			"rarity": "Uncommon",
			"tags": ["organic", "rare"],
			"base_storage_limit": 20.0,
			"base_production_rate": 0.02
		},
		ResourceType.SMALL_FISH: {
			"name": "Small Fish",
			"description": "Soft, damp plant growth found in shaded areas",
			"tier": 1,
			"category": "Natural Material",
			"rarity": "Uncommon",
			"tags": ["organic", "rare"],
			"base_storage_limit": 20.0,
			"base_production_rate": 0.02
		},
		ResourceType.CLAY: {
			"name": "Clay",
			"description": "Soft, damp plant growth found in shaded areas",
			"tier": 1,
			"category": "Natural Material",
			"rarity": "Uncommon",
			"tags": ["organic", "rare"],
			"base_storage_limit": 20.0,
			"base_production_rate": 0.02
		}
	}

## Resource Type Enum
enum ResourceType {
	CATNIP,
	TWIGS,
	LEAVES,
	MOSS,
	SPIDER_SILK,
	SMALL_FISH,
	CLAY
}

## Get metadata for a specific resource
static func get_resource_info(resource_type: int) -> Dictionary:
	var metadata = get_resource_metadata()
	return metadata.get(resource_type, {})

## Filter resources based on criteria
static func filter_resources(filter_criteria: Dictionary) -> Array:
	var matching_resources = []
	var metadata = get_resource_metadata()
	
	for resource_type in metadata:
		var resource_info = metadata[resource_type]
		var matches = true
		
		# Check each filter criterion
		for key in filter_criteria:
			if not resource_info.has(key) or resource_info[key] != filter_criteria[key]:
				matches = false
				break
		
		if matches:
			matching_resources.append({
				"type": resource_type,
				"metadata": resource_info
			})
	
	return matching_resources
