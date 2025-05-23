extends RigidBody3D

var resource_type = "Interactable"
var inventory_node
var currentCounter
var veg
var playerref
var chopping = false
var childlist : Array = []
@onready var timer = $Timer
var burning = false
func _ready():
	for child in get_children():
		childlist.append(child.name)
	currentCounter = self	
	
func _chop(Player: CharacterBody3D):
	if not burning:
		var chop = false
		for child in get_children():
			if Global.Veglist.has(child.name) and Global.Veglist.has("Chopped_"+child.name) :
				veg = child
				chop = true
		if chop and not chopping:
			playerref = Player
			chopping = true
			playerref.Freeze()
			timer.start()
			$ProgressBar.doChopping()
			Player.get_child(2).chopping = true
			$"Chopping".play()
		elif chop and chopping:
			Player.get_child(2).chopping = false
			$"Chopping".stop()
			chopping = false
			playerref.Freeze()
			timer.wait_time = timer.time_left
			timer.stop()
			$ProgressBar.pauseChopping()
	
# Function to activate and interact with all counter objects
func _activate(inventory_node):
	if not burning and inventory_node:
		if inventory_node.resources_inventory.size() > 0 and inventory_node.heldVegetable.get_some_variable() == "Food":
			inventory_node._place_item(currentCounter.get_path())  # Passing the NodePath of the current counter
		elif inventory_node.resources_inventory.size() > 0 and inventory_node.heldVegetable.get_some_variable() == "Plate":
			for child in get_children():
				if !childlist.has(child.name):
					inventory_node.heldVegetable.add_to_plate(child,inventory_node)
	else:
		print("Player node is not set")
##func process
	##if player presses 'b' unlcok player
func get_some_variable():
	return resource_type
func Iscuttingboard():
	pass

func _on_timer_timeout() -> void:
		playerref.Freeze()
		var chopped_key = "Chopped_" + veg.name
		var chopped_veg =  Global.VegDictionary[chopped_key].instantiate()
		get_parent().add_child(chopped_veg)
		chopped_veg.freeze = true
		chopped_veg.global_transform.origin = self.global_transform.origin+Vector3(0, .5, 0)
		veg.queue_free()
		timer.stop()
		timer.wait_time = 6
		chopping = false
		$"Chopping".stop()
		playerref.get_child(2).chopping = false
func onFire():
	burning = true
	var fire = preload("res://Fire.tscn").instantiate()
	add_child(fire)
	fire.transform.origin = Vector3(0, 1, 0)
