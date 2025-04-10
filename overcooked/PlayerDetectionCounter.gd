extends Area3D
var playerinside = false

func _on_area_body_entered(body):
	if body.name == "Player":
		body.get

func _on_area_body_exited(body):
	if body.name == "Player":
		playerinside = false
