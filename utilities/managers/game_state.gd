extends Node

## Game State Singleton
## Manages overall game state, time progression, and game systems

# Game Systems Managers
var resources: ResourceManager
var cats: CatManager 
#var buildings: BuildingManager
var exploration: ExplorationManager

# Time Management
var game_time: float = 0.0  # Total game time in seconds
var day: int = 1
var day_phase: String = "Morning"  # Morning, Afternoon, Evening, Night

# Save Game Variables
var last_saved_timestamp: int = 0
var autosave_interval: float = 300.0  # 5 minutes

# Timers
var game_timer: Timer
var autosave_timer: Timer

# Game State Tracking
var is_paused: bool = false
var game_difficulty: String = "Normal"

func _ready() -> void:
	# Initialize Managers
	resources = ResourceManager.new()
	cats = CatManager.new()
	#buildings = BuildingManager.new()
	exploration = ExplorationManager.new()
	
	# Add child managers to ensure they persist
	add_child(resources)
	add_child(cats)
	#add_child(buildings)
	add_child(exploration)
	
	# Setup Game Timers
	_setup_timers()
	
	# Load previous game state
	load_game()

func _setup_timers() -> void:
	# Game Update Timer (every 0.1 seconds)
	game_timer = Timer.new()
	game_timer.wait_time = 0.1
	game_timer.autostart = true
	game_timer.timeout.connect(_on_game_tick)
	add_child(game_timer)
	
	# Autosave Timer
	autosave_timer = Timer.new()
	autosave_timer.wait_time = autosave_interval
	autosave_timer.autostart = true
	autosave_timer.timeout.connect(_on_autosave)
	add_child(autosave_timer)

func _on_game_tick() -> void:
	if is_paused:
		return
	
	# Increment game time
	game_time += 0.1
	
	# Update day and phase
	_update_day_cycle()
	
	# Trigger system updates
	_update_game_systems()

func _update_day_cycle() -> void:
	# Approximately 24 minutes = 1 game day
	if game_time >= 1440.0:  # 24 * 60 * 0.1
		day += 1
		game_time = 0.0
	
	# Update day phase based on game time
	var hours = (game_time / 60.0)
	if hours < 6:
		day_phase = "Night"
	elif hours < 12:
		day_phase = "Morning"
	elif hours < 18:
		day_phase = "Afternoon"
	else:
		day_phase = "Evening"

func _update_game_systems() -> void:
	# Periodic updates for game systems
	resources.update(0.1)
	cats.update(0.1)
	#buildings.update(0.1)
	#exploration.update(0.1)

func _on_autosave() -> void:
	save_game()
	print("Game autosaved")

func save_game() -> void:
	# Update timestamp
	last_saved_timestamp = Time.get_unix_time_from_system()
	
	# Prepare save data
	var save_data = {
		"game_time": game_time,
		"day": day,
		"day_phase": day_phase,
		"difficulty": game_difficulty,
		"resources": resources.get_save_data(),
		"cats": cats.get_save_data(),
		#"buildings": buildings.get_save_data(),
		"exploration": exploration.get_save_data()
	}
	
	# Ensure save directory exists
	var dir = DirAccess.open("user://")
	if not dir.dir_exists("user://saves"):
		dir.make_dir("user://saves")
	
	# Save game data
	var save_file = FileAccess.open("user://saves/idlepaws_save.dat", FileAccess.WRITE)
	if save_file:
		save_file.store_line(JSON.stringify(save_data))
		save_file.close()
		print("Game saved successfully at " + get_formatted_last_saved_time())
	else:
		push_error("Failed to save game")

func load_game() -> void:
	# Check if save file exists
	if not FileAccess.file_exists("user://saves/idlepaws_save.dat"):
		print("No save file found. Starting new game.")
		return
	
	# Open and parse save file
	var save_file = FileAccess.open("user://saves/idlepaws_save.dat", FileAccess.READ)
	if save_file:
		var json_string = save_file.get_line()
		save_file.close()
		
		var parsed_data = JSON.parse_string(json_string)
		if parsed_data:
			# Restore game state
			game_time = parsed_data.get("game_time", 0.0)
			day = parsed_data.get("day", 1)
			day_phase = parsed_data.get("day_phase", "Morning")
			game_difficulty = parsed_data.get("difficulty", "Normal")
			
			# Restore system states
			resources.load_save_data(parsed_data.get("resources", {}))
			cats.load_save_data(parsed_data.get("cats", {}))
			#buildings.load_save_data(parsed_data.get("buildings", {}))
			exploration.load_save_data(parsed_data.get("exploration", {}))
			
			print("Game loaded successfully")
		else:
			push_error("Failed to parse save file")
	else:
		push_error("Failed to open save file")

func get_formatted_last_saved_time() -> String:
	if last_saved_timestamp == 0:
		return "Never"
	
	var current_time = Time.get_unix_time_from_system()
	var seconds_ago = current_time - last_saved_timestamp
	
	if seconds_ago < 60:
		return str(int(seconds_ago)) + " seconds ago"
	elif seconds_ago < 3600:
		return str(int(seconds_ago / 60)) + " minutes ago"
	else:
		var datetime = Time.get_datetime_dict_from_unix_time(last_saved_timestamp)
		return "%02d:%02d:%02d" % [datetime.hour, datetime.minute, datetime.second]

func set_game_difficulty(difficulty: String) -> void:
	game_difficulty = difficulty
	# Could trigger difficulty-specific adjustments here
	match difficulty:
		"Easy":
			# Adjust game mechanics for easier progression
			pass
		"Normal":
			# Standard game balance
			pass
		"Hard":
			# More challenging game mechanics
			pass

func pause_game() -> void:
	is_paused = true
	game_timer.stop()

func resume_game() -> void:
	is_paused = false
	game_timer.start()
