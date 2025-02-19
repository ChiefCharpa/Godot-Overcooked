extends Area3D

func _ready():
	set_collision_layer_bit(1, true)  # Set the collision layer
	set_collision_mask_bit(1, true)  # Set the collision mask
