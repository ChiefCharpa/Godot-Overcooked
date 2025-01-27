extends Area3D

var player_inventory = null
var body_to_activate = null

func _ready() -> void:
	player_inventory = get_parent().get_node("Inventory")
	if not is_connected("body_entered", Callable(self, "_on_body_entered")):
		self.connect("body_entered", Callable(self, "_on_body_entered"))

func _process(delta):
	if body_to_activate and Input.is_action_pressed("Interaction_Select"):
		if body_to_activate.name == "Tomato":
			body_to_activate.call("_activate", player_inventory)
			body_to_activate = null
		elif body_to_activate.name == "VegetableSpawner":
			body_to_activate.call("_activate")
			body_to_activate = null

func _on_body_entered(body):
	if body.has_method("_activate"):
		body_to_activate = body
