# theme_creator.gd
# You can run this script once to generate your theme file programmatically

extends Node

func _ready():
	create_cat_theme()
	print("Theme created successfully!")
	get_tree().quit()

func create_cat_theme():
	var theme = Theme.new()
	
	# Define our color palette
	var colors = {
		"background_color": Color("#F0F2F5"),
		"header_color": Color("#5D4A66"),
		"sidebar_color": Color("#3D4A5C"),
		"sidebar_button_color": Color("#4D5A6C"),
		"accent_color_orange": Color("#FF7F50"),
		"accent_color_gold": Color("#F0A500"),
		"progress_bar_color": Color("#5F9EA0"),
		"avatar_color": Color("#D8BFD8"),
		"panel_color": Color("#E6E9EF"),
		"text_color": Color("#333333"),
		"text_color_light": Color("#FFFFFF"),
		"text_color_dim": Color("#CCCCCC")
	}
	
	# Add colors to theme
	for color_name in colors:
		theme.set_color(color_name, "Global", colors[color_name])
	
	# Set default font size
	theme.set_default_font_size(14)
	
	# Configure Panel style
	var panel_style = StyleBoxFlat.new()
	panel_style.bg_color = colors["panel_color"]
	panel_style.corner_radius_top_left = 5
	panel_style.corner_radius_top_right = 5
	panel_style.corner_radius_bottom_left = 5
	panel_style.corner_radius_bottom_right = 5
	panel_style.content_margin_left = 10
	panel_style.content_margin_right = 10
	panel_style.content_margin_top = 10
	panel_style.content_margin_bottom = 10
	theme.set_stylebox("panel", "Panel", panel_style)
	
	# Configure Button styles
	# Normal state
	var button_normal = StyleBoxFlat.new()
	button_normal.bg_color = colors["sidebar_button_color"]
	button_normal.corner_radius_top_left = 5
	button_normal.corner_radius_top_right = 5
	button_normal.corner_radius_bottom_left = 5
	button_normal.corner_radius_bottom_right = 5
	button_normal.content_margin_left = 10
	button_normal.content_margin_right = 10
	button_normal.content_margin_top = 8
	button_normal.content_margin_bottom = 8
	theme.set_stylebox("normal", "Button", button_normal)
	
	# Hover state
	var button_hover = button_normal.duplicate()
	button_hover.bg_color = colors["sidebar_button_color"].lightened(0.1)
	theme.set_stylebox("hover", "Button", button_hover)
	
	# Pressed state
	var button_pressed = button_normal.duplicate()
	button_pressed.bg_color = colors["sidebar_button_color"].darkened(0.1)
	theme.set_stylebox("pressed", "Button", button_pressed)
	
	# Focus state
	var button_focus = StyleBoxFlat.new()
	button_focus.bg_color = Color(0, 0, 0, 0)  # Transparent
	button_focus.border_width_top = 1
	button_focus.border_width_left = 1
	button_focus.border_width_right = 1
	button_focus.border_width_bottom = 1
	button_focus.border_color = colors["accent_color_orange"]
	button_focus.corner_radius_top_left = 5
	button_focus.corner_radius_top_right = 5
	button_focus.corner_radius_bottom_left = 5
	button_focus.corner_radius_bottom_right = 5
	theme.set_stylebox("focus", "Button", button_focus)
	
	# Selected state (for navigation menu)
	var button_selected = button_normal.duplicate()
	button_selected.bg_color = colors["accent_color_orange"]
	theme.set_stylebox("selected", "Button", button_selected)
	
	# Set Button text colors
	theme.set_color("font_color", "Button", colors["text_color_light"])
	theme.set_color("font_focus_color", "Button", colors["text_color_light"])
	theme.set_color("font_hover_color", "Button", colors["text_color_light"])
	theme.set_color("font_pressed_color", "Button", colors["text_color_light"])
	
	# Configure Label styles
	theme.set_color("font_color", "Label", colors["text_color"])
	
	# Configure ProgressBar styles
	var progress_bg = StyleBoxFlat.new()
	progress_bg.bg_color = colors["header_color"]
	progress_bg.corner_radius_top_left = 10
	progress_bg.corner_radius_top_right = 10
	progress_bg.corner_radius_bottom_left = 10
	progress_bg.corner_radius_bottom_right = 10
	theme.set_stylebox("background", "ProgressBar", progress_bg)
	
	var progress_fill = StyleBoxFlat.new()
	progress_fill.bg_color = colors["progress_bar_color"]
	progress_fill.corner_radius_top_left = 10
	progress_fill.corner_radius_top_right = 10
	progress_fill.corner_radius_bottom_left = 10
	progress_fill.corner_radius_bottom_right = 10
	theme.set_stylebox("fill", "ProgressBar", progress_fill)
	
	# Configure LineEdit styles
	var line_edit_normal = StyleBoxFlat.new()
	line_edit_normal.bg_color = colors["text_color_light"]
	line_edit_normal.border_width_bottom = 1
	line_edit_normal.border_width_top = 1
	line_edit_normal.border_width_left = 1
	line_edit_normal.border_width_right = 1
	line_edit_normal.border_color = colors["sidebar_button_color"]
	line_edit_normal.corner_radius_top_left = 3
	line_edit_normal.corner_radius_top_right = 3
	line_edit_normal.corner_radius_bottom_left = 3
	line_edit_normal.corner_radius_bottom_right = 3
	line_edit_normal.content_margin_left = 5
	line_edit_normal.content_margin_right = 5
	line_edit_normal.content_margin_top = 5
	line_edit_normal.content_margin_bottom = 5
	theme.set_stylebox("normal", "LineEdit", line_edit_normal)
	
	# Create a header panel style
	var header_style = StyleBoxFlat.new()
	header_style.bg_color = colors["header_color"]
	header_style.corner_radius_top_left = 0
	header_style.corner_radius_top_right = 0
	header_style.corner_radius_bottom_left = 0
	header_style.corner_radius_bottom_right = 0
	theme.set_stylebox("header", "Panel", header_style)
	
	# Create a sidebar panel style
	var sidebar_style = StyleBoxFlat.new()
	sidebar_style.bg_color = colors["sidebar_color"]
	sidebar_style.corner_radius_top_left = 0
	sidebar_style.corner_radius_top_right = 0
	sidebar_style.corner_radius_bottom_left = 0
	sidebar_style.corner_radius_bottom_right = 0
	theme.set_stylebox("sidebar", "Panel", sidebar_style)
	
	# Create a statusbar panel style
	var statusbar_style = StyleBoxFlat.new()
	statusbar_style.bg_color = colors["sidebar_color"]
	statusbar_style.corner_radius_top_left = 0
	statusbar_style.corner_radius_top_right = 0
	statusbar_style.corner_radius_bottom_left = 0
	statusbar_style.corner_radius_bottom_right = 0
	theme.set_stylebox("statusbar", "Panel", statusbar_style)
	
	# Save the theme
	var err = ResourceSaver.save(theme, "res://cat_theme.tres")
	if err != OK:
		print("Error saving theme: ", err)
