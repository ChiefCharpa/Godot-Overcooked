extends RigidBody3D
var resource_type = "Interactable"
var PlayerInventory
# Called when the node enters the scene tree for the first time.
func _activate():
	var areachild = get_node("Area3D")
	var new_root = get_tree().root.get_node("LevelNode")
	var parent = new_root.get_node("Player") 
	for child in parent.get_children():
			if child.name=="Inventory":
				PlayerInventory = child
				PlayerInventory._drop_item(0)
	if areachild.resources_inventory != []:
		var lastitem = areachild.resources_inventory[-1]
		print(areachild.resources_inventory)  # See what the array contains
		print(areachild.resources_inventory[-1])
		if Global.Veglist.has(lastitem) and PlayerInventory.can_pickup:
			PlayerInventory.add_resources(lastitem)
			areachild.resources_inventory.pop_back()
			get_node("Area3D").can_delete = false
			await get_tree().create_timer(0.2).timeout
			get_node("Area3D").can_delete = true

func get_some_variable():
	return resource_type
