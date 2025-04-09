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
		if inventory_node.resources_inventory.size() > 0:
			inventory_node._place_item(currentCounter.get_path())  # Passing the NodePath of the current counter
		##if player holds nothing, while there is a food item on cutting board
			##lock the player in front of the cutting board
			##when player press 'e' chop 
	else:
		print("Player node is not set")
##func process
	##if player presses 'b' unlcok player
func get_some_variable():
	return resource_type
