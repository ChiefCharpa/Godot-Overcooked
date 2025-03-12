extends Area3D
 # Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", _on_body_entered)

func _on_body_entered(body):
	if body.get("resource_type") and body.resource_type == "Food": #if the object has a resource type and its food
		var new_root = get_tree().root.get_node("LevelNode")
		var parent = new_root.get_node("Player") #get the player
		for child in parent.get_children(): #look through all the children
			if child.name =="Inventory": #get the inventory child
				child.resources_inventory.clear() #clear the inventory
			if child.name == "InteractionCheckerArea3D":
				child.body_to_activate = null
		body.queue_free()  # Deletes the item
