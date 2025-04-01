# LocationDefinitions.gd
class_name LocationDefinitions

# Enum for location IDs (for easy reference)
enum LocationID {
	GARDEN_AREA,
	FOREST_EDGE,
	RIVERSIDE,
	ABANDONED_LOT,
	ANCIENT_RUINS
}

# Enum for gathering spot IDs
enum SpotID {
	GRASSY_PATCH,
	SMALL_BUSHES,
	DAMP_CORNERS,
	TALL_TREES,
	HOLLOW_LOG,
	SPIDER_CORNER,
	SHALLOW_WATERS,
	ROCKY_BANK
}

# Get all location definitions
static func get_location_definitions() -> Dictionary:
	return {
		# Garden Area (Starting Location)
		"garden_area": {
			"name": "Garden Area",
			"description": "A peaceful garden with various plants and small creatures.",
			"is_unlocked": true,  # Starting location is unlocked by default
			"required_level": 1,
			"thumbnail_image": "res://assets/images/locations/garden.png",
			"proximity_bonus": {},  # No bonuses for starter location
			"travel_time": 0,  # Home location by default
			"spots": ["grassy_patch", "small_bushes", "damp_corners"]
		},
		
		# Forest Edge Location
		"forest_edge": {
			"name": "Forest Edge",
			"description": "The outskirts of a dense forest with taller trees and more resources.",
			"is_unlocked": false,
			"required_level": 3,
			"thumbnail_image": "res://assets/images/locations/forest.png",
			"proximity_bonus": {
				ItemDefinitions.ResourceType.TWIGS: 25,
				ItemDefinitions.ResourceType.LEAVES: 20
			},
			"travel_time": 10,
			"spots": ["tall_trees", "hollow_log", "spider_corner"]
		},
		
		# Riverside Location
		"riverside": {
			"name": "Riverside",
			"description": "A flowing river with shallow areas and a rocky bank.",
			"is_unlocked": false,
			"required_level": 4,
			"thumbnail_image": "res://assets/images/locations/riverside.png",
			"proximity_bonus": {
				ItemDefinitions.ResourceType.SMALL_FISH: 30,
				ItemDefinitions.ResourceType.CLAY: 25
			},
			"travel_time": 25,
			"spots": ["shallow_waters", "rocky_bank"]
		}
		
		# Add more locations as needed
	}

# Get all gathering spot definitions
static func get_gathering_spot_definitions() -> Dictionary:
	return {
		# Garden Area Spots
		"grassy_patch": {
			"name": "Grassy Patch",
			"description": "A lush area of grass where catnip grows naturally.",
			"energy_cost": 5,
			"gathering_time": 3.0,
			"is_locked": false,  # Starting spot is unlocked
			"unlock_costs": {},
			"thumbnail_image": "res://assets/images/spots/grassy_patch.png",
			"required_level": 1,
			"required_tools": [],
			"yields": [
				{
					"resource_type": ItemDefinitions.ResourceType.CATNIP,
					"min_amount": 1,
					"max_amount": 3,
					"chance": 1.0
				}
			]
		},
		
		"small_bushes": {
			"name": "Small Bushes",
			"description": "Small bushes with thin branches good for gathering twigs.",
			"energy_cost": 8,
			"gathering_time": 4.0,
			"is_locked": false,  # Also unlocked from the start
			"unlock_costs": {},
			"thumbnail_image": "res://assets/images/spots/small_bushes.png",
			"required_level": 1,
			"required_tools": [],
			"yields": [
				{
					"resource_type": ItemDefinitions.ResourceType.TWIGS,
					"min_amount": 1,
					"max_amount": 2,
					"chance": 1.0
				},
				{
					"resource_type": ItemDefinitions.ResourceType.LEAVES,
					"min_amount": 0,
					"max_amount": 1,
					"chance": 0.5
				}
			]
		},
		
		"damp_corners": {
			"name": "Damp Corners",
			"description": "Shaded, damp areas where moss tends to grow.",
			"energy_cost": 7,
			"gathering_time": 5.0,
			"is_locked": true,
			"unlock_costs": {
				ItemDefinitions.ResourceType.TWIGS: 20,
				ItemDefinitions.ResourceType.LEAVES: 10
			},
			"thumbnail_image": "res://assets/images/spots/damp_corners.png",
			"required_level": 1,
			"required_tools": [],
			"yields": [
				{
					"resource_type": ItemDefinitions.ResourceType.MOSS,
					"min_amount": 0,
					"max_amount": 1,
					"chance": 0.5
				}
			]
		},
		
		# Forest Edge Spots
		"tall_trees": {
			"name": "Tall Trees",
			"description": "Taller trees with more branches and leaves.",
			"energy_cost": 8,
			"gathering_time": 5.0,
			"is_locked": false,  # Unlocked when the location is unlocked
			"unlock_costs": {},
			"thumbnail_image": "res://assets/images/spots/tall_trees.png",
			"required_level": 1,
			"required_tools": [],
			"yields": [
				{
					"resource_type": ItemDefinitions.ResourceType.TWIGS,
					"min_amount": 1,
					"max_amount": 2,
					"chance": 1.0
				},
				{
					"resource_type": ItemDefinitions.ResourceType.LEAVES,
					"min_amount": 2,
					"max_amount": 4,
					"chance": 1.0
				},
				{
					"resource_type": ItemDefinitions.ResourceType.SPIDER_SILK,
					"min_amount": 0,
					"max_amount": 1,
					"chance": 0.1
				}
			]
		},
		
		"hollow_log": {
			"name": "Hollow Log",
			"description": "A fallen log with a hollow center, home to various small creatures.",
			"energy_cost": 10,
			"gathering_time": 6.0,
			"is_locked": false,  # Unlocked when the location is unlocked
			"unlock_costs": {},
			"thumbnail_image": "res://assets/images/spots/hollow_log.png",
			"required_level": 1,
			"required_tools": [],
			"yields": [
				{
					"resource_type": ItemDefinitions.ResourceType.MOSS,
					"min_amount": 0,
					"max_amount": 1,
					"chance": 0.5
				},
				{
					"resource_type": ItemDefinitions.ResourceType.TWIGS,
					"min_amount": 1,
					"max_amount": 2,
					"chance": 1.0
				}
			]
		},
		
		"spider_corner": {
			"name": "Spider Corner",
			"description": "A corner of the forest with abandoned spider webs.",
			"energy_cost": 12,
			"gathering_time": 8.0,
			"is_locked": true,
			"unlock_costs": {
				ItemDefinitions.ResourceType.TWIGS: 50
			},
			"thumbnail_image": "res://assets/images/spots/spider_corner.png",
			"required_level": 1,
			"required_tools": [],
			"yields": [
				{
					"resource_type": ItemDefinitions.ResourceType.SPIDER_SILK,
					"min_amount": 0,
					"max_amount": 1,
					"chance": 0.4
				}
			]
		},
		
		# Add more gathering spots as needed
	}
