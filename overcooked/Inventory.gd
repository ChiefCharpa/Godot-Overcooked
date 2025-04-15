extends Node3D

class_name Inventory

var resources_inventory : Dictionary = { }
var heldVegetable = null
var can_pickup = true

func add_resources(item : Node3D):
	if can_pickup:
		item.get_parent().remove_child(item)
		get_parent().add_child(item)
		resources_inventory[item.name]=1
		item.axis_lock_linear_y = true #locks y transform
		item.global_transform.origin = global_transform.origin + global_transform.basis.z * -1 + Vector3(0, 0.4, 0)
		item.freeze = true
		heldVegetable = item

func deletehelditem():
	if heldVegetable != null:
		heldVegetable.get_parent().remove_child(heldVegetable)
		heldVegetable = null
		resources_inventory.clear()

func _drop_item(force):
	if heldVegetable != null:
		heldVegetable.freeze = false
		print("Dropping",heldVegetable)
		heldVegetable.get_parent().remove_child(heldVegetable) #removes the item being held from the player node
		var new_root = get_tree().root.get_node("LevelNode") #gets the level node
		new_root.add_child(heldVegetable) #adds the held item to the level node
		heldVegetable.global_transform.origin = global_transform.origin + global_transform.basis.z * -1 + Vector3(0, 0.4, 0) #assigns its pos
		heldVegetable.axis_lock_linear_y = false #unlocks ths y transform
		
		#throw the held object
		##not currently working
		var throw_direction = -global_transform.basis.z.normalized()
		print("Throwing vegetable with force: ", force)
		print("Throw direction: ", throw_direction)
		heldVegetable.apply_impulse(Vector3(), throw_direction * force)
		heldVegetable = null
		##end
		 
		resources_inventory.clear() #clears inventory
		
		can_pickup=false
		await get_tree().create_timer(0.2).timeout  #makes sure the player doesnt drop and the immedietly pickup and fuse two objects
		can_pickup = true

func _place_item(currentCounter: NodePath, itemPos: int, itemAngle: float):
	if heldVegetable != null:
		if currentCounter != null and get_tree().get_root().has_node(currentCounter):
			heldVegetable.get_parent().remove_child(heldVegetable) # removes the item being held from the player node
			var new_root = get_tree().get_root().get_node(currentCounter) # gets the current selected counter node
			if new_root != null:
				new_root.add_child(heldVegetable) # adds the held item to the current selected counter node
				heldVegetable.global_transform.origin = new_root.global_transform.origin + Vector3(0, itemPos/2.0, 0) # places the item on top of the counter
				heldVegetable.global_transform.basis = Basis(Vector3(0, 0, 1), itemAngle)
				heldVegetable = null
				resources_inventory.clear() # clears inventory
			else:
				print("Error: Node path for currentCounter is invalid or not found")
		else:
			print("Error: currentCounter is an invalid path")
	else:
		print("No item is being held")
