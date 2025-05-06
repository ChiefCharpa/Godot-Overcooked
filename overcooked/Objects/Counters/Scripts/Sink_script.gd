extends RigidBody3D

var resource_type = "Interactable"
var inventory_node
var cleanSpawner
var currentCounter
var playerref
var washing = false
var dirtylist : Array = []
var plate = true
@onready var timer = $Timer
var burning = false
func _ready():
	cleanSpawner  = get_node("/root/LevelNode/Sink/Area3D")
	currentCounter = self	

func _chop(Player: CharacterBody3D):
	var wash = false
	if dirtylist.size() > 0:
		wash = true
	if wash and not washing:
		playerref = Player
		washing = true
		playerref.Freeze()  # Freeze the player to simulate washing
		timer.start()  # Start the washing timer
	elif wash and washing:
		washing = false
		playerref.Freeze()  # Unfreeze the player
		timer.wait_time = timer.time_left
		timer.stop()

# Function to activate and interact with all counter objects
func _activate(inventory_node):
	if not burning and inventory_node:
		if inventory_node.resources_inventory.size() > 0:
			if inventory_node.heldVegetable.has_method("dirtyPlate"):
				inventory_node.heldVegetable.call("dirtyPlate") #calls the _activate method
				dirtylist.append(inventory_node.heldVegetable)  # Add the new dirty plate
				var platePos = 0.4 * dirtylist.size() + .3
				print(platePos)
				var plateAngle = deg_to_rad(45)
				inventory_node.sink_place_item(currentCounter.get_path(), platePos, plateAngle)  # Pass the NodePath to the counter
	else:
		print("Player node is not set")
	print(dirtylist)

func get_some_variable():
	return resource_type

func Iscuttingboard():
	pass

func _on_timer_timeout() -> void:
	if dirtylist.size() > 0:
		playerref.Freeze()  # Freeze the player again after the cleaning process
		if cleanSpawner and cleanSpawner.has_method("spawnPlate"):
			cleanSpawner.spawnPlate()
		else:
			print("Could not find cleanSpawner or method is missing.")
		var currentItem = dirtylist[dirtylist.size() - 1]
		dirtylist.remove_at(dirtylist.size() - 1)
		currentItem.queue_free()
		timer.stop()
		timer.wait_time = 1  # Reset the timer
		washing = false
func onFire():
	burning = true
	var fire = preload("res://Fire.tscn").instantiate()
	add_child(fire)
	fire.transform.origin = Vector3(0, 1, 0)
