extends RigidBody3D

func spawn():
		var plate_scene = load("res://Objects/Containers/Plate.tscn")
		var spawnedplate = plate_scene.instantiate()
		spawnedplate.global_position = self.global_position + Vector3(0,0.6,0.8)
		get_parent().get_parent().add_child(spawnedplate)
