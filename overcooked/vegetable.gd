extends RigidBody3D

@export var resource_amount: int
var player_inventory = null
var resource_type = "Food"

func _activate(player_inventory):
	if player_inventory:
		player_inventory.add_resources(self.name, resource_amount) #adds tomato to inventory 
		queue_free() #removes tomato object


func get_some_variable():
	return resource_type
