extends RigidBody3D
var resource_type = "Interactable"
var inventory_node
var currentCounter
var burning = false
func _ready() -> void:
	await get_tree().process_frame
	currentCounter = self
	self.freeze = true
	spawn()

func spawn():
		var spawned = preload("res://Objects/Containers/Pan.tscn").instantiate()
		spawned.global_position = self.global_position + Vector3(0.08,0.55,0)
		get_parent().get_parent().add_child(spawned)
		spawned.onstove = true
		spawned.stove = currentCounter.get_path()

func _activate(inventory_node):
	if not burning and inventory_node:
			if inventory_node.resources_inventory.size() > 0:
				if inventory_node.heldVegetable.has_method("ispan"): 
					inventory_node.heldVegetable.onstove = true
					inventory_node.heldVegetable.cook(currentCounter.get_path())
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
