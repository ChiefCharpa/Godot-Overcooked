extends Node

class_name Inventory

@export var resources_inventory : Dictionary = { }

func add_resources(type : Resource, amount : int):
	if(resources_inventory.has(type)):
		resources_inventory[type] += amount
	else:
		resources_inventory[type] = amount
