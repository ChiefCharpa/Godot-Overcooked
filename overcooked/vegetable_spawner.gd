extends RigidBody3D
var resource_type = "Interactable"
var inventory_node
var currentCounter

func _ready():
	inventory_node = get_node("/root/LevelNode/Player/Inventory")
	currentCounter = self
	
func _activate():
	if inventory_node:
		if player_inventory and player_inventory.can_pickup ==true: #makes sure the player isnt holding something
			var newVegetable = VEGETABLE.instantiate()
			get_parent().add_child(newVegetable)
			newVegetable.global_position=global_position+Vector3(0,0.4,0) #sets tomato pos
		else:
			inventory_node._place_item(currentCounter.get_path())  # Passing the NodePath of the current counter
		
func get_some_variable():
	return resource_type
