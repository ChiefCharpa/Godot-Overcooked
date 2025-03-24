extends RigidBody3D

class_name Plate
var resource_type
var held_vegetables: Array = []

func _ready():
	self.freeze = true
	resource_type = "Plate" # Define the plate as a container


func add_vegetable(veg: Node3D,player_inventory):
	if veg.resource_type == "Food":
		held_vegetables.append(veg.name)
		var newveg = Global.VegDictionary.get(veg.name).instantiate()
		player_inventory.deletehelditem()
		add_child(newveg)
		var offset = Vector3(0, 0.1 + 0.2 * held_vegetables.size(), 0)
		newveg.freeze = true
		newveg.get_node("CollisionShape3D").disabled = true
		newveg.transform.origin = offset


func pickup(player_inventory):
	player_inventory.add_container(self)

func place(player_inventory):
	player_inventory._drop_item(0)

func _activate():
	pass

func get_some_variable():
	return resource_type
func freeme():
	queue_free()
