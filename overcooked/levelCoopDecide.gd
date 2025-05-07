extends Node3D
var PlayerScene = preload("res://playerChef2.tscn")

func _ready() -> void:
	if Global.coop == true:
		var player_instance = PlayerScene.instantiate()
		player_instance.global_position = Vector3(0, 1, 0)  # or .position for 2D
		get_tree().current_scene.add_child(player_instance)
