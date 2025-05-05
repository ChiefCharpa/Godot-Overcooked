extends RigidBody3D

var player_inventory = null
var resource_type = "Food"

@rpc("any_peer", "reliable", "call_local")
func _activate(player_inventory_path: NodePath):
	var player_inventory = get_node_or_null(player_inventory_path)
	if player_inventory and player_inventory.can_pickup == true:
		player_inventory.add_resources(self)


func get_some_variable():
	return resource_type
