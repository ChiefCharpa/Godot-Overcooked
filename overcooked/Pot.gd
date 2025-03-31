extends Area3D

var resources_inventory = []
var heldVegetable = null
var can_delete = true
var pot = true

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", _on_body_entered)
	get_parent().freeze = true

func _on_body_entered(body): #take the item that is dropped, adds it to the pot inventory and the deletes the item
	if body.get("resource_type") and body.resource_type == "Food" and can_delete and Global.Veglist.has(body.name) and len(resources_inventory)<3: #if the object has a resource type and its food
		resources_inventory.append(body.get_name()) #adds item name to inventory
		body.queue_free()
		var new_root = get_tree().root.get_node("LevelNode")
		var parent = new_root.get_node("Player") #get the player
		for child in parent.get_children(): #look through all the children
			if child.name =="Inventory": #get the inventory child
				child.resources_inventory.clear() #clear the inventory
			if child.name == "InteractionCheckerArea3D":
				child.body_to_activate = null  # Deletes the item
				
