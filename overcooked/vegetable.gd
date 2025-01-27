extends RigidBody3D

@export var resource_amount: int
var player_inventory = null

func _ready() -> void:
	linear_velocity = Vector3(0, 2, 0.5)

func _activate(player_inventory):
	if player_inventory:
		player_inventory.add_resources(self.name, resource_amount)
		queue_free()
