extends Node

#region Instructions
'''
How to use
# Print the current scene's hierarchy to the console
NodeTreeUtility.print_to_console()

# Save the current scene's hierarchy to a file
NodeTreeUtility.save_node_tree()

# Save a specific node's hierarchy to a custom filename
NodeTreeUtility.save_node_tree($YourNode, "your_node_structure.txt")

'''
#endregion








# Saves node tree to a file
func save_node_tree(root_node=null, filename="node_hierarchy.txt"):
	# Use the provided root node or default to scene tree root
	if root_node == null:
		root_node = get_tree().get_root()
	
	# Create a file for writing
	var file = FileAccess.open("user://" + filename, FileAccess.WRITE)
	
	if file:
		file.store_line("NODE HIERARCHY:")
		file.store_line("")
		print_node_tree(root_node, 0, file)
		file.close()
		print("Node hierarchy saved to user://" + filename)
		return true
	else:
		print("Failed to open file for writing")
		return false

# Prints node tree to console
func print_to_console(root_node=null):
	# Use the provided root node or default to scene tree root
	if root_node == null:
		root_node = get_tree().get_root()
	
	print("\nNODE HIERARCHY:\n")
	print_node_tree(root_node)
	return true

# Internal function that does the actual tree building
func print_node_tree(node, depth = 0, file = null):
	# Create the line prefix
	var line = ""
	
	# Add tree structure
	if depth > 0:
		for i in range(depth-1):
			line += "│  "
		line += "├─"
	
	# Add node information
	line += node.name + " (" + node.get_class() + ")"
	
	# Write to file if file is provided
	if file:
		file.store_line(line)
	else:
		# Fallback to console output if no file
		print(line)
	
	# Process children
	for child in node.get_children():
		print_node_tree(child, depth + 1, file)
