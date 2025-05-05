extends RigidBody3D

var resource_type = "Interactable"
var inventory_node = null
var cleanSpawner
var currentCounter
var playerref
var washing = false
var dirtylist : Array = []
@onready var timer = $Timer

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

@rpc("any_peer", "reliable", "call_local")
func place(inventory_node_path: NodePath):
	var inventory_node = get_node(inventory_node_path)
	if inventory_node and inventory_node.heldVegetable and inventory_node.heldVegetable.has_method("dirtyPlate"):
		inventory_node.heldVegetable.dirtyPlate()
		dirtylist.append(inventory_node.heldVegetable)

		var platePos = 0.4 * dirtylist.size() + 0.3
		var plateAngle = deg_to_rad(45)
		inventory_node.sink_place_item(currentCounter.get_path(), platePos, plateAngle)
	else:
		print("Inventory node or heldVegetable is missing or invalid.")

func _activate(inventory_node):
	if inventory_node:
		if inventory_node.resources_inventory.size() > 0:
			if inventory_node.heldVegetable and inventory_node.heldVegetable.has_method("dirtyPlate"):
				place.rpc(inventory_node.get_path())
	else:
		print("Player node is not set")


func get_some_variable():
	return resource_type

func Iscuttingboard():
	pass

func _on_timer_timeout() -> void:
	if dirtylist.size() > 0:
		playerref.Freeze()  # Freeze the player again after the cleaning process
		if cleanSpawner and cleanSpawner.has_method("spawnPlate"):
			cleanSpawner.spawnPlate.rpc()
		else:
			print("Could not find cleanSpawner or method is missing.")
		var currentItem = dirtylist[dirtylist.size() - 1]
		dirtylist.remove_at(dirtylist.size() - 1)
		killItem.rpc(currentItem.get_path())
		timer.stop()
		timer.wait_time = 1  # Reset the timer
		washing = false

@rpc("any_peer", "reliable", "call_local")
func killItem(currentItemPath: NodePath):
	var currentItem = get_node(currentItemPath)
	currentItem.queue_free()
