extends Area3D
@onready var spread_timer = $Timer

func _on_timer_timeout():
	for body in get_overlapping_bodies():
		if body.has_method("onFire") and body.burning == false:
			print("spread")
			body.onFire()
