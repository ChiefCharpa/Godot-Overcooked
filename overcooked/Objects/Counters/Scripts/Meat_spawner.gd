extends RigidBody3D
var resource_type = "Interactable"
var inventory_node
var currentCounter
var Veg = Global.VegDictionary.get("Meat")
var burning = false
var childList = []
func _ready():
	currentCounter = self
	
func _activate(inventory_node):
	if not burning and inventory_node:
		childList = []
		for child in get_children():
			childList.append(child)
		if inventory_node.resources_inventory.size() == 0 and childList.size() <= 4:
			var newVegetable = Veg.instantiate()
			get_parent().add_child(newVegetable)
			newVegetable.global_position=global_position+Vector3(0,0.4,0) #sets tomato pos
			newVegetable.call("_activate",inventory_node)
		elif inventory_node.resources_inventory.size() != 0 and childList.size() <= 4:
			inventory_node._place_item(currentCounter.get_path())  # Passing the NodePath of the current counter
		
func get_some_variable():
	return resource_type
func onFire():
	burning = true
	var fire = preload("res://Fire.tscn").instantiate()
	add_child(fire)
	fire.transform.origin = Vector3(0, 1, 0)
