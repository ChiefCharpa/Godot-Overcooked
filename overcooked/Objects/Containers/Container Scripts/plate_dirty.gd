extends RigidBody3D

var player_inventory = null
var resource_type = "Plate"
var held_vegetables: Array = []
var childlist: Array = []
var pickupable = true

func add_vegetable(veg: Node3D,player_inventory):
	pass

@rpc("any_peer", "reliable", "call_local")
func pickup(player_inventory_path: NodePath):
	var player_inventory = get_node_or_null(player_inventory_path)
	if player_inventory:
		player_inventory.add_container(self)

func place(player_inventory):
	player_inventory._drop_item(0)

func _activate():
	pass

func get_some_variable():
	return resource_type

func dirtyPlate():
	pickupable = false

func freeme():
	queue_free()

func clear_plate():
	if held_vegetables.size() > 0:
		for child in get_children():
			if !childlist.has(child.name):
				child.queue_free()
		held_vegetables.clear()
