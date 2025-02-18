extends Area3D

var player_inventory = null
var body_to_activate = null
var resource_type = null

func _ready() -> void:
	player_inventory = get_parent().get_node("Inventory")
	if not is_connected("body_entered", Callable(self, "_on_body_entered")):
		self.connect("body_entered", Callable(self, "_on_body_entered"))

func _process(delta):
	if body_to_activate and Input.is_action_pressed("Interaction_Select"):
		if resource_type == "Food":
			body_to_activate.call("_activate", player_inventory) #calls the _activate func in each item
			body_to_activate = null #clears body_to_acitvate after picking up the item
		elif resource_type == "Interactable":
			body_to_activate.call("_activate") #calls the _activate func in each interactable
			##for chopping/washing ect player xyz should be locked in front of station for the wash/chop event
			##for chopping/washing ect do if 'B' (back) pressed it exits out of the wash/chop event
			body_to_activate = null #clears body_to_acitvate after interacting
		elif resource_type == "containers":
			pass

func _on_body_entered(body):
	if body.has_method("_activate"):
		resource_type = body.get_some_variable()
		body_to_activate = body
