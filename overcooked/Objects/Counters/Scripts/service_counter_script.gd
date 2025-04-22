extends RigidBody3D

var resource_type = "Interactable"
var inventory_node
var currentCounter
var cookedDish
var recipes: Array = [["Soup_Tomato"], ["Soup_Onion"], ["Soup_Mushroom"]]
var orders: Array = []
var plateSpawnNode
@onready var order_Timer = $place_Order_Timer

func _ready():
	inventory_node = get_node("/root/LevelNode/Player/Inventory")
	plateSpawnNode = get_node("/root/LevelNode/Service_Counter/Counter_Rigidbody")
	currentCounter = self
	start_random_timer()
	_on_RandomTimer_timeout()

func start_random_timer():
	var new_time = randf_range(10.0, 30.0)
	order_Timer.wait_time = new_time
	order_Timer.start()

func _on_RandomTimer_timeout():
	var random_number = randi_range(0, 2)
	orders.append(recipes[random_number])
	print("new order", orders)
	# Restart with a new randomized time
	start_random_timer()

func _activate():
	if inventory_node:
		if inventory_node.resources_inventory.size() > 0:
			if inventory_node.heldVegetable.has_method("cleanPlate"):
				cookedDish = inventory_node.heldVegetable
				inventory_node._place_item(currentCounter.get_path())  # Passing the NodePath of the current counter
				for order in orders:
					print(order)
					print(cookedDish.held_vegetables)
					
					# If held_vegetables contains strings, directly append them to the list
					var held_vegetable_names = []
					for item in cookedDish.held_vegetables:
						held_vegetable_names.append(str(item))  # Convert StringName to String
					held_vegetable_names.sort()
					order.sort()

					# Check if the sorted lists match
					if held_vegetable_names == order:

						# Order is complete, remove the cookedDish and erase the order
						cookedDish.queue_free()
						orders.erase(order)
						plateSpawnNode.call("spawn")
						print("Order completed and removed:", order)
					else:
						print("Order doesn't match:", order)
	else:
		print("Player node is not set")




func get_some_variable():
	return resource_type
	
