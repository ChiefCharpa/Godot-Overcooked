extends Node3D

class_name Inventory

var resources_inventory : Dictionary = { }
var heldVegetable = null ##figure out a way to do any item
var can_pickup = true

func add_resources(food : Node3D):
	if can_pickup == true:
		if Global.Veglist.has(food.name):
			food.get_parent().remove_child(food)
			get_parent().add_child(food)
			resources_inventory[food.name]=1
			food.axis_lock_linear_y = true #locks y transform
			food.global_transform.origin = global_transform.origin + global_transform.basis.z * -1 + Vector3(0, 0.4, 0)
			food.freeze = true
			heldVegetable = food
func add_from_container(food : Node3D):
	if can_pickup == true:
		if Global.Veglist.has(food.name):
			get_parent().add_child(food)
			resources_inventory[food.name]=1
			food.axis_lock_linear_y = true #locks y transform
			food.global_transform.origin = global_transform.origin + global_transform.basis.z * -1 + Vector3(0, 0.4, 0)
			food.freeze = true
			heldVegetable = food
	
func add_container(container: Node3D):
	if can_pickup:
		container.get_parent().remove_child(container)
		get_parent().add_child(container)
		resources_inventory[container.name]=1
		container.axis_lock_linear_y = true #locks y transform
		container.global_transform.origin = global_transform.origin + global_transform.basis.z * -1 + Vector3(0, 0.4, 0)
		container.freeze = true
		heldVegetable = container
func deletehelditem():
	if heldVegetable != null:
		heldVegetable.get_parent().remove_child(heldVegetable)
		heldVegetable = null
		resources_inventory.clear()

func _drop_item(force):
	if heldVegetable != null:
		heldVegetable.freeze = false
		print("Dropping", heldVegetable)
		heldVegetable.get_parent().remove_child(heldVegetable)
		var new_root = get_tree().root.get_node("LevelNode")
		new_root.add_child(heldVegetable)
		
		# Place the item just in front of the player
		var drop_position = global_transform.origin + global_transform.basis.z * -1 + Vector3(0, 0.4, 0)
		heldVegetable.global_transform.origin = drop_position
		
		heldVegetable.axis_lock_linear_y = false
		
		# Apply a throwing force if requested
		if force > 0 and heldVegetable is RigidBody3D:
			var direction = -global_transform.basis.z.normalized()
			heldVegetable.linear_velocity = direction * force + Vector3(0, 2, 0)  # arc upward a bit

		heldVegetable = null
		 
		resources_inventory.clear()
		can_pickup = false
		await get_tree().create_timer(0.2).timeout
		can_pickup = true

##these 2 functions can be mixed together but it will be complex
func _place_item(currentCounter: NodePath):
	if heldVegetable != null:
		if currentCounter != null and get_tree().get_root().has_node(currentCounter):
			heldVegetable.get_parent().remove_child(heldVegetable) # removes the item being held from the player node
			var new_root = get_tree().get_root().get_node(currentCounter) # gets the current selected counter node
			if new_root != null:
				new_root.add_child(heldVegetable) # adds the held item to the current selected counter node
				if heldVegetable.has_method("ispot"):
					heldVegetable.global_transform.origin = new_root.global_transform.origin + Vector3(0.1, 0.8, 0)
				elif heldVegetable.has_method("ispan"):
					heldVegetable.global_transform.origin = new_root.global_transform.origin + Vector3(0.1, 0.5, 0)
				else:
					heldVegetable.global_transform.origin = new_root.global_transform.origin + Vector3(0, .5, 0) # places the item on top of the counter
				heldVegetable = null
				resources_inventory.clear() # clears inventory
			else:
				print("Error: Node path for currentCounter is invalid or not found")
		else:
			print("Error: currentCounter is an invalid path")
	else:
		print("No item is being held")

func sink_place_item(currentCounter: NodePath, itemPos: float, itemAngle: float):
	if heldVegetable != null:
		if currentCounter != null and get_tree().get_root().has_node(currentCounter):
			heldVegetable.get_parent().remove_child(heldVegetable) # removes the item being held from the player node
			var new_root = get_tree().get_root().get_node(currentCounter) # gets the current selected counter node
			if new_root != null:
				new_root.add_child(heldVegetable) # adds the held item to the current selected counter node
				heldVegetable.global_transform.origin = new_root.global_transform.origin + Vector3(-.7, itemPos/2.0, 0) # places the item on top of the counter
				heldVegetable.global_transform.basis = Basis(Vector3(0, 0, 1), itemAngle)
				heldVegetable = null
				resources_inventory.clear() # clears inventory
