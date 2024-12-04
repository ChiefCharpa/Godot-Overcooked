extends Node3D

@onready var spawntimer = $Timer

const VEGETABLE = preload("res://Vegetable.tscn")

func _on_timer_timeout() -> void:
	var newVegetable = VEGETABLE.instantiate()
	get_parent().add_child(newVegetable)
	newVegetable.global_position=global_position+Vector3(0,0.4,0)
