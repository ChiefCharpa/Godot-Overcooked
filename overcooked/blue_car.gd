extends Node3D

@export var speed: float = 2.0          
@export var distance: float = 75.0       
@export var direction: Vector3 = Vector3.LEFT

var startPosition: Vector3

func _ready():
	startPosition = global_position

func _process(delta):
	global_position += direction.normalized() * speed * delta

	var distanceMoved = (global_position - startPosition).length()
	if distanceMoved >= distance:
		global_position = startPosition
