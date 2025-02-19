extends Node3D

@onready var Player = $"../Player"
@onready var Veg = $"."
var DetectionRange = 1.4
var InRange = false
var SpawnDelay = true
const VEGETABLE = preload("res://Vegetable.tscn")
	

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed() and SpawnDelay and InRange:
		if Input.is_action_pressed("Interact"):
			var newVegetable = VEGETABLE.instantiate()
			get_parent().add_child(newVegetable)
			newVegetable.global_position=global_position+Vector3(0,0.4,0)
			SpawnDelay = false
			await get_tree().create_timer(1).timeout #delays spawning by 1 second
			SpawnDelay = true

func _process(delta): #So this could be change so it does an area but this is simple and works
	var distance = Veg.transform.origin.distance_to(Player.transform.origin)
	if distance < DetectionRange:
		InRange = true
	else:
		InRange =false
