extends RigidBody3D

var resource_type = "Interactable"
var inventory_node
var currentCounter
var currentItem = null
var choppedAmmount
var Veg = Global.VegDictionary
var choppedVeg = Global.choppedVegDictionary
var spawnVeg
	
func _ready():
	inventory_node = get_node("/root/LevelNode/Player/Inventory")
	currentCounter = self

# Function to activate and interact with all counter objects
func _activate():
	if inventory_node:
		if inventory_node.resources_inventory.size() > 0:
			var foodPos = 1
			var foodAngle = 0
			currentItem = inventory_node.heldVegetable
			choppedAmmount = 5
			if inventory_node.heldVegetable.has_method("placedInSink"):
				inventory_node.heldVegetable.placedInSink()
			inventory_node._place_item(currentCounter.get_path(), foodPos, foodAngle)  # Passing the NodePath of the current counter

	if currentItem != null and inventory_node.resources_inventory.size() == 0 and currentItem.name in Veg:
		choppedAmmount -= 1
		print(choppedAmmount)
		if choppedAmmount == 0:
			var choppedItem = "Chopped_" + currentItem.name
			if choppedVeg.has(choppedItem):
				spawnVeg = choppedVeg[choppedItem]
				currentItem.queue_free()
				var spawnedVeg = spawnVeg.instantiate()
				spawnedVeg.global_position = self.global_position + Vector3(0, 0.6, 0.8)
				get_parent().get_parent().add_child(spawnedVeg)
			else:
				print("Could not find chopped version for:", choppedItem)
	else:
		print("Player node is not seTTTTTTTTTTTTTTTTt")

func get_some_variable():
	return resource_type
