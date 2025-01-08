extends RigidBody3D

@export var resource_amount : int
@export var resource_type : Resource

func _ready() -> void:
	linear_velocity = Vector3(0, 2, 0.5)
	contact_monitor = true
	max_contacts_reported = 1
	if not is_connected("body_entered", Callable(self, "_on_body_entered")):
		self.connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):    
	if body is CharacterBody3D:  # Ensure body is Player
		var player_inventory = body.inventory
		if player_inventory:
			player_inventory.add_resources(resource_type, resource_amount)
			queue_free()
