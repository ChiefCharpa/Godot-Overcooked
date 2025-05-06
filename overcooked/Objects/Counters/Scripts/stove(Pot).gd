extends RigidBody3D
var resource_type = "Interactable"
var inventory_node
var currentCounter
func _ready() -> void:
	await get_tree().process_frame
	currentCounter = self
	self.freeze = true
	spawn()

func spawn():
		var spawned = preload("res://Objects/Containers/Pot.tscn").instantiate()
		spawned.global_position = self.global_position + Vector3(0.08,0.8,0.78)
		get_parent().get_parent().add_child(spawned)
		spawned.onstove = true

func _activate(inventory_node):
	if inventory_node:
		if inventory_node.resources_inventory.size() > 0:
			if inventory_node.heldVegetable.has_method("ispan"):
				inventory_node.heldVegetable.onstove = true
				inventory_node.heldVegetable.cook()
				inventory_node._place_item(currentCounter.get_path())  # Passing the NodePath of the current counter
	else:
		print("Player node is not set")
func get_some_variable():
	return resource_type
