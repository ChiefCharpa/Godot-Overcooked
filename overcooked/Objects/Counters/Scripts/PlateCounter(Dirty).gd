extends RigidBody3D
var resource_type = "Interactable"

func _ready() -> void:
	await get_tree().process_frame
	self.freeze = true


func _activate(inventory_node):
	var spawnedplate = Global.VegDictionary.get("Plate_Dirty").instantiate()
	spawnedplate.global_position = self.global_position + Vector3(0,0.6,0.8)
	spawnedplate.freeze = true
	get_parent().get_parent().add_child(spawnedplate)
		

func spawn():
	var spawnedplate = Global.VegDictionary.get("Plate_Dirty").instantiate()
	spawnedplate.global_position = self.global_position + Vector3(0,0.6,0.8)
	spawnedplate.freeze = true
	get_parent().get_parent().add_child(spawnedplate)

func get_some_variable():
	return resource_type
