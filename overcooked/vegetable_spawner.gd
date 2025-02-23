extends Area3D

const VEGETABLE = preload("res://Vegetable.tscn")
var resource_type = "Interactable"

func _activate():
	var bodies = get_overlapping_bodies() #get everything inside the area
	for body in bodies: #for each thing in the area
		for child in body: #for each child of the thing in the area
			if child.name== "Inventory":
				if child.heldVegetable == null: #if the player isnt holding anything
					var newVegetable = VEGETABLE.instantiate()
					get_parent().add_child(newVegetable)
					newVegetable.global_position=global_position+Vector3(0,0.4,0) #sets tomato pos
	
	
func get_some_variable():
	return resource_type
