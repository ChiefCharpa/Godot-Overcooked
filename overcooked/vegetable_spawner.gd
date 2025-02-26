extends RigidBody3D
var resource_type = "Interactable"
var Tomato = Global.VegDictionary.get("Tomato")

func _activate():
	var newVegetable = Tomato.instantiate()
	get_parent().add_child(newVegetable)
	newVegetable.global_position=global_position+Vector3(0,0.4,0) #sets tomato pos

func get_some_variable():
	return resource_type
