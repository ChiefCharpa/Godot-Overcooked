extends Node3D

class_name Inventory

@export var resources_inventory : Dictionary = { }
var heldVegetable
const VEGETABLE = preload("res://Vegetable.tscn") ##figure out a way to do any item
var h = true

##Built only for tomatos
func add_resources(name : String, amount : int):
	if(resources_inventory.has(name)):
		resources_inventory[name] += amount #adds 1 to inventory item count
	else:
		resources_inventory[name] = amount #adds item to inventory
		heldVegetable = VEGETABLE.instantiate() #spawns vegetable
		get_parent().add_child(heldVegetable) #adds held item to player node
		heldVegetable.axis_lock_linear_y = true #locks y transform
		heldVegetable.global_transform.origin = global_transform.origin + global_transform.basis.z * -1 + Vector3(0, 0.4, 0) #assigns its pos
##do a 2nd inv for containers due to the secondary list in containers (pots, plates)

##as of rn it only will be able to spit tomatos out
##dropped item dosnt seem to move x and z axis
##pressing e picks up the item like its still in the interaction collider
func _drop_item():
	if h == false:
		if heldVegetable != null:
			heldVegetable.get_parent().remove_child(heldVegetable) #removes the item being held from the player node
			var new_root = get_tree().root.get_node("LevelNode") #gets the level node
			new_root.add_child(heldVegetable) #adds the held item and adds it to the level node
			heldVegetable.global_transform.origin = global_transform.origin + global_transform.basis.z * -1 + Vector3(0, 0.4, 0) #assigns its pos
			heldVegetable.axis_lock_linear_y = false #unlocks ths y transform
			heldVegetable = null
			resources_inventory.clear() #clears inventory
			
func _place_item(currentCounter: NodePath):
	if heldVegetable != null:
		if currentCounter != null and get_tree().get_root().has_node(currentCounter):
			heldVegetable.get_parent().remove_child(heldVegetable) # removes the item being held from the player node
			var new_root = get_tree().get_root().get_node(currentCounter) # gets the current selected counter node
			if new_root != null:
				new_root.add_child(heldVegetable) # adds the held item to the current selected counter node
				heldVegetable.global_transform.origin = new_root.global_transform.origin + Vector3(0, .5, 0) # places the item on top of the counter
				heldVegetable = null
				resources_inventory.clear() # clears inventory
			else:
				print("Error: Node path for currentCounter is invalid or not found")
		else:
			print("Error: currentCounter is an invalid path")
	else:
		print("No item is being held")
