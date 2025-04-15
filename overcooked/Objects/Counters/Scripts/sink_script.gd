extends RigidBody3D

var resource_type = "Interactable"
var inventory_node
var currentCounter
var outer_PlateList = []
var currentItem
var PlateSpawn_node

func _ready():
	inventory_node = get_node("/root/LevelNode/Player/Inventory")
	PlateSpawn_node = get_node("/root/LevelNode/Sink/PlateSpawner_Rigidbody")
	currentCounter = self

# Function to activate and interact with all counter objects
func _activate():
	if inventory_node:
		if inventory_node.resources_inventory.size() > 0:
			if inventory_node.heldVegetable.resource_type == "dirtyPlate":
				inventory_node.heldVegetable.placedInSink()
				var inner_PlateList = [inventory_node.heldVegetable, 5]
				outer_PlateList.append(inner_PlateList)
				var platePos = outer_PlateList.size()
				var plateAngle = deg_to_rad(45)
				inventory_node._place_item(currentCounter.get_path(), platePos, plateAngle)  # Passing the NodePath of the current counter
		
		elif outer_PlateList.size() > 0 and inventory_node.resources_inventory.size() == 0:
			var plateBack = outer_PlateList.size() - 1
			currentItem = outer_PlateList[plateBack][0]
			outer_PlateList[plateBack][1] -= 1
			print(outer_PlateList[plateBack][1])
			if outer_PlateList[plateBack][1] == 0:
				outer_PlateList.remove_at(plateBack)
				currentItem.queue_free()
				PlateSpawn_node.spawn()

	else:
		print("Player node is not set")

func get_some_variable():
	return resource_type
