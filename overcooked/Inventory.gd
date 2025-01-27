extends Node

class_name Inventory

@export var resources_inventory : Dictionary = { }

func add_resources(name : String, amount : int):
	if(resources_inventory.has(name)):
		resources_inventory[name] += amount
	else:
		resources_inventory[name] = amount
