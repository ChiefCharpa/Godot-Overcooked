extends Node3D

const VEGETABLE = preload("res://Vegetable.tscn")
var resource_type = "Interactable"
var inventory_node
var currentCounter

func _ready():
	inventory_node = get_node("/root/LevelNode/Player/Inventory")
	currentCounter = self
	
func _activate():
	if inventory_node:
		if inventory_node.resources_inventory.size() == 0:
			var newVegetable = VEGETABLE.instantiate()
			get_parent().add_child(newVegetable)
			newVegetable.global_position=global_position+Vector3(0,0.4,0) #sets tomato pos
		else:
			inventory_node._place_item(currentCounter.get_path())  # Passing the NodePath of the current counter
		
func get_some_variable():
	return resource_type
