extends Control

# These Variales will track the current content.
var current_content = null
var current_button = null


func _ready():
	#calls function to connect all navigation signals
	connect_navigation_buttons()
	   
	
	#default Scene: Home
	var home_button = %HomeButton
	_on_nav_button_pressed(home_button)
	
	#NodeTreeUtility.print_to_console()

func connect_navigation_buttons():
	var nav_buttons = %NavigationVBOX.get_children()
	for button in nav_buttons:
		# Use the bind() method to pass the button itself as an argument
		button.connect("pressed", _on_nav_button_pressed.bind(button))
		

func _on_nav_button_pressed(button): #when button is pressed
	#Future, update button styling
	
	#Switch the content dispaleyd in main scene.
	switch_content(button.name)

func switch_content(button_name): # switch content based on Button Name
	if current_content: # removeing existing content if exist
		current_content.queue_free()
		
		
	# Map ButtonNames with their Scene
	var content_scene = null
	match button_name:
		"HomeButton":
				content_scene = load("res://scenes/home/home_scene.tscn")
		"CatropolisButton":
				content_scene = load("res://scenes/catropolis/catropolis_scene.tscn")
		"ExplorationButton":
				content_scene = load("res://scenes/exploration/exploration_scene.tscn")
		"GatheringButton":
				content_scene = load("res://scenes/gathering/gathering_scene.tscn")
	#instantiate the scene to the main content panel
	if content_scene:
		current_content = content_scene.instantiate()
		%MainContentDisplay.add_child(current_content)
