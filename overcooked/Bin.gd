extends RigidBody3D

var resource_type = "Interactable"
var inventory_node
var currentCounter

func _ready():
	self.freeze = true
	inventory_node = get_node("/root/LevelNode/Player/Inventory")
	currentCounter = self

# Function to activate and interact with all counter objects
func _activate():
	if inventory_node:
		if inventory_node.resources_inventory.size() > 0:
			var new_root = get_tree().root.get_node("LevelNode")
			var parent = new_root.get_node("Player") # Get the player
			for child in parent.get_children(): # Look through all the children
				if child.name == "Inventory": # Get the inventory child
					child.resources_inventory.clear() # Clear the inventory
				if child.has_method("get_some_variable"):
					var resource_type = child.get_some_variable() # Get the resource type from the body
					if resource_type == "Food" or resource_type == "Plate":
						child.queue_free() # Delete the item
	else:
		print("Player node is not set")

func get_some_variable():
	return resource_type
