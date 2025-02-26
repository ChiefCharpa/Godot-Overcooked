extends Node3D

class_name Inventory

var resources_inventory : Dictionary = { }
var heldVegetable = null ##figure out a way to do any item
var can_pickup = true

##Built only for tomatos
func add_resources(name : String):
	if can_pickup == true:
		if Global.Veglist.has(name):
			resources_inventory[name] = 1 #adds item to inventory
			heldVegetable = Global.VegDictionary.get(name).instantiate() #spawns vegetable
			get_parent().add_child(heldVegetable) #adds held item to player node
			heldVegetable.axis_lock_linear_y = true #locks y transform
			heldVegetable.global_transform.origin = global_transform.origin + global_transform.basis.z * -1 + Vector3(0, 0.4, 0) #assigns its pos
	##do a 2nd inv for containers due to the secondary list in containers (pots, plates)

##as of rn it only will be able to spit tomatos out
##dropped item dosnt seem to move x and z axis
##pressing g picks up the item like its still in the interaction collider
func _drop_item():
	if heldVegetable != null:
		print("Dropping",heldVegetable)
		heldVegetable.get_parent().remove_child(heldVegetable) #removes the item being held from the player node
		var new_root = get_tree().root.get_node("LevelNode") #gets the level node
		new_root.add_child(heldVegetable) #adds the held item to the level node
		heldVegetable.global_transform.origin = global_transform.origin + global_transform.basis.z * -1 + Vector3(0, 0.4, 0) #assigns its pos
		heldVegetable.axis_lock_linear_y = false #unlocks ths y transform
		heldVegetable = null
		resources_inventory.clear() #clears inventory
		can_pickup=false
		await get_tree().create_timer(0.2).timeout  #makes sure the player doesnt drop and the immedietly pickup and fuse two objects
		can_pickup = true
