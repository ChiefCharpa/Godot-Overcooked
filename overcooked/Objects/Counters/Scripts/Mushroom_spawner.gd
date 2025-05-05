extends RigidBody3D

var resource_type = "Interactable"
var inventory_node = null
var currentCounter
var Veg = Global.VegDictionary.get("Mushroom")

func _ready():
	currentCounter = self

func _activate(inventory_node):
	if inventory_node:
		var path = inventory_node.get_path()
		spawn_and_activate.rpc(path)

@rpc("any_peer", "reliable", "call_local")
func spawn_and_activate(inventory_path: NodePath):
	var inventory_node = get_node_or_null(inventory_path)
	if inventory_node == null:
		print("Inventory node not found at path:", inventory_path)
		return

	if inventory_node.resources_inventory.size() == 0:
		var new_vegetable = Veg.instantiate()
		get_parent().add_child(new_vegetable)

		new_vegetable.global_position = global_position + Vector3(0, 0.4, 0)

		if new_vegetable.has_method("_activate"):
			new_vegetable._activate(inventory_node.get_path())
	else:
		if inventory_node.has_method("_place_item"):
			inventory_node._place_item(currentCounter.get_path())

func get_some_variable():
	return resource_type
