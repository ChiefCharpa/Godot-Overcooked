extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", _on_body_entered)

func _on_body_entered(body):
	if body.get("resource_type") and body.resource_type == "Food":
		var parent = body.get_parent()
		for child in parent.get_children():
			if child.name =="Inventory":
				child.resources_inventory.clear()
		body.queue_free()  # Deletes the object safely
		
