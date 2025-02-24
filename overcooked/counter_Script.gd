extends RigidBody3D

var resource_type = "Interactable"
var inventory_node
var currentCounter

func _ready():
	inventory_node = get_node("/root/LevelNode/Player/Inventory")
	currentCounter = self

# Function to activate and interact with all counter objects
func _activate():
	if inventory_node:
		inventory_node._place_item(currentCounter.get_path())  # Passing the NodePath of the current counter
	else:
		print("Player node is not set")

func get_some_variable():
	return resource_type
