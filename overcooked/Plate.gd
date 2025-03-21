extends RigidBody3D

class_name Plate
var resource_type
var held_vegetables: Array = []

func _ready():
	resource_type = "Plate" # Define the plate as a container

func add_vegetable(veg: Node3D):
	if veg.resource_type == "Food":
		held_vegetables.append(veg) # Remove from world
		add_child(veg) # Attach to plate
		veg.set_deferred("freeze", true) 
		veg.global_transform.origin = global_transform.origin + Vector3(0, 0.1 * held_vegetables.size(), 0) # Stack veggies
		veg.resource_type == "Plated" # Disable interaction with the vegetable
		heldVegetable.get_parent().remove_child(heldVegetable)

func pickup(player_inventory):
	player_inventory.add_resources("Plate")
	queue_free()

func place(player_inventory):
	player_inventory._drop_item(0)

func _activate():
	pass

func get_some_variable():
	return resource_type
func freeme():
	queue_free()
