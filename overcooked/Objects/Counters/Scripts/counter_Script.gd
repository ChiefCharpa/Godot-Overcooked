extends RigidBody3D

var resource_type = "Interactable"
var inventory_node
var currentCounter
var burning = false
func _ready():
	currentCounter = self

# Function to activate and interact with all counter objects
func _activate(inventory_node):
	if not burning and inventory_node:
		if inventory_node.resources_inventory.size() > 0:
			inventory_node._place_item(currentCounter.get_path())  # Passing the NodePath of the current counter
	else:
		print("Player node is not set")

func get_some_variable():
	return resource_type
func onFire():
	burning = true
	var fire = preload("res://Fire.tscn").instantiate()
	add_child(fire)
	fire.transform.origin = Vector3(0, 1, 0)
