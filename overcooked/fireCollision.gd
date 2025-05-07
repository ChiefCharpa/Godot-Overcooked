extends Area3D
var health = 10
var currentCounter = null
var fireNode

func _ready() -> void:
	currentCounter = get_parent().get_parent()
	fireNode = get_parent()
func _process(delta: float) -> void:
	if health == 0:
		print(currentCounter)
		currentCounter.burning = false
		fireNode.queue_free()
	for body in get_overlapping_bodies():
		if body.name == "Foam":
			health = health - 1
