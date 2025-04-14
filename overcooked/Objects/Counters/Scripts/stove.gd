extends RigidBody3D
var resource_type = "Interactable"
var inventory_node
var currentCounter
func _ready() -> void:
	await get_tree().process_frame
	inventory_node = get_node("/root/LevelNode/Player/Inventory")
	currentCounter = self
	self.freeze = true
	spawn()

func spawn():
		var spawned = preload("res://Objects/Containers/Pan.tscn").instantiate()
		spawned.global_position = self.global_position + Vector3(0,0.45,0.7)
		get_parent().get_parent().add_child(spawned)

func _activate():
	if inventory_node:
		if inventory_node.resources_inventory.size() > 0:
			if inventory_node.heldVegetable.has_method("ispan"):
				inventory_node._place_item(currentCounter.get_path())  # Passing the NodePath of the current counter
	else:
		print("Player node is not set")
func get_some_variable():
	return resource_type
