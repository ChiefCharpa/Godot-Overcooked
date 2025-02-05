extends Node

class_name Inventory

@export var resources_inventory : Dictionary = { }
const VEGETABLE = preload("res://Vegetable.tscn")

func add_resources(name : String, amount : int):
	if(resources_inventory.has(name)):
		resources_inventory[name] += amount
	else:
		resources_inventory[name] = amount#

##as of rn it only will be able to spit tomatos out 
func _drop_item():
	if resources_inventory.has("Tomato"):
		var newVegetable = VEGETABLE.instantiate()
		get_parent().add_child(newVegetable)
		resources_inventory.clear()
