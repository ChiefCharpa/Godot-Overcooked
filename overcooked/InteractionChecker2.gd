extends Area3D

@export var AnimPlayer: String; # calls the path of the animation player

var animatePlayer = null
var player_inventory = null #stores the player's inventory
var body_to_activate = null #stores the body to be activated
var resource_type = null #stores the type of resource
var inventory_node #stores the inventory node
var action_processed = false #tracks if the action is processed
var currently_hold = false # records if the player if currently holding item
var chopping = false
var force = 0



func _ready() -> void:
	player_inventory = get_parent().get_node("Inventory2") #gets the player's inventory
	inventory_node = get_node("/root/LevelNode/Player2/Inventory2") #gets the inventorys node path
	animatePlayer = get_parent().get_node(AnimPlayer);## gets the players animation script

func _process(delta):
	var overlapping_bodies = get_overlapping_bodies()
	body_to_activate = null
	
	for body in overlapping_bodies:
		if body.has_method("dirtyPlate") and body.pickupable:
			resource_type = body.get_some_variable()
			body_to_activate = body
		elif body.has_method("_activate") and not body.has_method("dirtyPlate") and body != player_inventory.heldVegetable:
			resource_type = body.get_some_variable()
			body_to_activate = body

	# Chopping check
	if Input.is_action_just_pressed("Chop2"):
		for body in overlapping_bodies:
			if body.has_method("Iscuttingboard"):
				resource_type = body.get_some_variable()
				body.call("_chop", self.get_parent())
				if "plate" in body:
					animatePlayer.call("_changeState", 6)
				else:
					animatePlayer.call("_changeState", 3)
				
	##variable simplification for readability
	var press_interact := Input.is_action_just_pressed("Interaction_Select2")
	var press_throw := Input.is_action_just_pressed("Throw_Item2")
	var has_item : bool = player_inventory.resources_inventory.size() != 0
	var held_not_plate : bool = player_inventory.heldVegetable != null and player_inventory.heldVegetable.get_some_variable() != "Plate"
	var nothing_or_food : bool = (body_to_activate == null or resource_type == "Food")


	if (!currently_hold and has_item):
		animatePlayer.call("_changeState", 4)
		currently_hold = true;

	# Drop item if player presses interact/throw with food or nothing
	if ((press_interact and nothing_or_food) or press_throw) and has_item and held_not_plate and not action_processed and !chopping:
		if press_throw:
			force = 10
		else:
			force = 0
		inventory_node._drop_item(force)
		action_processed = true
		animatePlayer.call("_changeHolding")
		currently_hold = false;

	# Interact logic
	elif press_interact and body_to_activate and not action_processed and !chopping:
		action_processed = true
		var held_plate : bool = player_inventory.heldVegetable != null and player_inventory.heldVegetable.get_some_variable() == "Plate"

		if held_plate and resource_type == "Food":
			player_inventory.heldVegetable.add_to_plate(body_to_activate, player_inventory)
		elif held_plate and body_to_activate.has_method("ispan") and !player_inventory.heldVegetable.has_method("ispan"):
			player_inventory.heldVegetable.add_to_plate(body_to_activate.take_from_pan(), player_inventory)
		elif resource_type == "Food":
			body_to_activate.call("_activate", player_inventory)
		elif resource_type in ["Interactable", "containers"]:
			body_to_activate.call("_activate", player_inventory)
		elif resource_type == "Plate":
			if player_inventory.heldVegetable != null and not held_plate:
				body_to_activate.call("add_vegetable", player_inventory.heldVegetable, player_inventory)
			elif player_inventory.heldVegetable == null:
				body_to_activate.call("pickup", player_inventory)
				if player_inventory.heldVegetable.has_method("ispot"):
					body_to_activate.onstove = false
				if player_inventory.heldVegetable.has_method("ispan"):
					body_to_activate.call("cook")
			elif player_inventory.heldVegetable != null:
				body_to_activate.place(player_inventory)

	# Backup drop logic (optional, could remove if above block covers everything)
	elif (press_interact and nothing_or_food or press_throw) and has_item and !chopping:
		inventory_node._drop_item(force)
		action_processed = true
		animatePlayer.call("_changeHolding")
		currently_hold = false;

	# Reset interaction flag
	elif not Input.is_action_pressed("Interaction_Select") and !chopping:
		action_processed = false
		
	if (currently_hold and !has_item):
		animatePlayer.call("_changeHolding");
		currently_hold = false;
