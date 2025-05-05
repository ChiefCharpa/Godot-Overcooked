extends RigidBody3D

var resource_type = "Interactable"
var inventory_node
var currentCounter

func _ready():
	currentCounter = self

# Function to activate and interact with all counter objects
func _activate(inventory_node):
	if inventory_node:
		place.rpc(inventory_node.get_path())
		
@rpc("any_peer", "reliable", "call_local")
func place(inventory_path: NodePath):
	var inventory_node = get_node_or_null(inventory_path)
	if inventory_node == null:
		print("Inventory node not found at path:", inventory_path)
		return

	if inventory_node.resources_inventory.size() > 0:
		inventory_node._place_item(currentCounter.get_path())

func get_some_variable():
	return resource_type
