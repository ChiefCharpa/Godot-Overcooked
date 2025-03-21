extends Area3D
var player_inventory = null #stores the player's inventory
var body_to_activate = null #stores the body to be activated
var resource_type = null #stores the type of resource
var inventory_node #stores the inventory node
var action_processed = false #tracks if the action is processed
var force = 0
var pickupable = true

func _ready() -> void:
	player_inventory = get_parent().get_node("Inventory") #gets the player's inventory
	inventory_node = get_node("/root/LevelNode/Player/Inventory") #gets the inventorys node path

func _process(delta):
	#gets the bodies overlapping with the area
	var overlapping_bodies = get_overlapping_bodies()
	body_to_activate = null #resets body_to_activate before checking for overlapping bodies
	
	for body in overlapping_bodies:
		if body.has_method("_activate"):
			resource_type = body.get_some_variable() #gets the resource type from the body
			body_to_activate = body #sets body_to_activate to the current body
			print(body_to_activate.name)

	#checks if 'e' is pressed, if there is not an interatable obj, if the item in front is type food
	#and that theres an item in the invt
	if ((Input.is_action_just_pressed("Interaction_Select") and (body_to_activate == null or resource_type == "Food")) or Input.is_action_just_pressed("Throw_Item"))  and player_inventory.resources_inventory.size() != 0 and not action_processed:
		inventory_node._drop_item(force) #calls the drop_item method
		action_processed = true #set action_processed to true
	#checks if 'e' is pressed, there is an item in the area and that there is no action currently being processed
	elif Input.is_action_pressed("Interaction_Select") and body_to_activate and not action_processed:
		action_processed = true #sets action_processed to true
		if resource_type == "Food":
			body_to_activate.call("_activate", player_inventory) #calls the _activate method

		elif resource_type == "Interactable":
			if player_inventory.heldVegetable != null and player_inventory.heldVegetable.name == "Plate":
				pickupable = true
			body_to_activate.call("_activate") #calls the _activate method

		elif resource_type == "containers":
			body_to_activate.call("_activate")
		elif resource_type == "Plate":
			if player_inventory.heldVegetable != null and player_inventory.heldVegetable.name != "Plate": #if the player is holding somthing that isnt a plate
				body_to_activate.call("add_vegetable",player_inventory.heldVegetable,player_inventory) #call add vegetable
			elif pickupable == true and player_inventory.heldVegetable == null:
				body_to_activate.call("pickup",player_inventory)
				await get_tree().create_timer(0.2).timeout
				pickupable = false
			elif player_inventory.heldVegetable != null and pickupable == false and player_inventory.heldVegetable.name == "Plate" :
				pickupable = true
				inventory_node._drop_item(0)
				
			

	#resets action_processed to false when interaction select action is not pressed
	elif not Input.is_action_pressed("Interaction_Select"):
		action_processed = false
