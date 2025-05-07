extends RigidBody3D

var resource_type = "Interactable"
var inventory_node
var currentCounter
var burning = false
var childList = []
func _ready():
	currentCounter = self
	var spawnedplate = Global.VegDictionary.get("Plate").instantiate()
	spawnedplate.global_position = Vector3(0,0.6,0)
	print("Placing plate at:", spawnedplate.global_position)
	spawnedplate.freeze = true
	add_child(spawnedplate)


# Function to activate and interact with all counter objects
func _activate(inventory_node):
	childList = []
	for child in get_children():
		childList.append(child)
	if not burning and inventory_node and childList.size() <= 1:
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
