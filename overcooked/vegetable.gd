extends RigidBody3D

var player_inventory = null
var resource_type = "Food"
var canPickup = true

func _activate(player_inventory):
	if player_inventory and player_inventory.can_pickup ==true: #makes sure the player isnt holding something
		if canPickup == true:
			player_inventory.add_resources(self) #adds tomato to inventory 

func placedInSink():
	canPickup = false

func get_some_variable():
	return resource_type
