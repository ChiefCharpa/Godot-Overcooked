extends RigidBody3D
var resource_type = "Interactable"
const VEGETABLE = preload("res://Vegetable.tscn")

func _activate():
	var newVegetable = VEGETABLE.instantiate()
	get_parent().add_child(newVegetable)
	newVegetable.global_position=global_position+Vector3(0,0.4,0) #sets tomato pos

func get_some_variable():
	return resource_type
