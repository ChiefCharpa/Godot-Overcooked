extends RigidBody3D

var player_inventory = null
var resource_type = "Food"

func _activate(player_inventory):
	if player_inventory and player_inventory.can_pickup ==true: #makes sure the player isnt holding something
		player_inventory.add_resources(self.name) #adds tomato to inventory 
		queue_free() #removes tomato object


func get_some_variable():
	return resource_type
