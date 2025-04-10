extends RigidBody3D

var resource_type = "Interactable"
var inventory_node
var currentCounter
@onready var timer = $Timer

func _ready():
	inventory_node = get_node("/root/LevelNode/Player/Inventory")
	currentCounter = self	

func _chop(Player: CharacterBody3D):
	var chop = false
	for child in self.get_children():
		if Global.Veglist.has(child.name):
			chop = true
	if chop:
		Player.Freeze()
		await get_tree().create_timer(10.0).timeout
		Player.Freeze()
	
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
