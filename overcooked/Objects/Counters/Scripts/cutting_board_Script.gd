extends RigidBody3D

var resource_type = "Interactable"
var inventory_node
var currentCounter
var veg
var playerref
var chopping = false
@onready var timer = $Timer

func _ready():
	inventory_node = get_node("/root/LevelNode/Player/Inventory")
	currentCounter = self	
	
func _chop(Player: CharacterBody3D):
	var chop = false
	for child in self.get_children():
		if Global.Veglist.has(child.name):
			veg = child
			chop = true
	if chop and not chopping:
		playerref = Player
		chopping = true
		playerref.Freeze()
		timer.start()
	elif chop and chopping:
		chopping = false
		playerref.Freeze()
		timer.wait_time = timer.time_left
		timer.stop()

	
# Function to activate and interact with all counter objects
func _activate():
	if inventory_node:
		if inventory_node.resources_inventory.size() > 0:
			inventory_node._place_item(currentCounter.get_path())  # Passing the NodePath of the current counter
		##if player holds nothing, while there is a food item on cutting board
			##lock the player in front of the cutting board
			##when player press 'x' chop 
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
		print(chopped_veg.name)
		get_parent().add_child(chopped_veg)
		chopped_veg.global_position = veg.global_position
		veg.queue_free()
		timer.stop()
		timer.wait_time = 10
		chopping = false
