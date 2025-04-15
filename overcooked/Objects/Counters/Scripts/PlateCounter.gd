extends RigidBody3D
var resource_type = "Interactable"
func _ready() -> void:
	await get_tree().process_frame
	self.freeze = true
	spawn()

func spawn():
	var plate = load("res://Objects/Containers/Plate_Dirty.tscn")
	var spawnedplate = plate.instantiate()
	spawnedplate.global_position = self.global_position + Vector3(0,0.6,0.8)
	get_parent().get_parent().add_child(spawnedplate)

func _activate():
		spawn()
		
func get_some_variable():
	return resource_type
