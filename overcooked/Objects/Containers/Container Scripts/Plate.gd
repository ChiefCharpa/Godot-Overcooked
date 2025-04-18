extends RigidBody3D

var resource_type
var held_vegetables: Array = []
var childlist: Array = []

func _ready():
	self.freeze = true
	resource_type = "Plate" # Define the plate as a container
	for child in get_children():
		childlist.append(child.name)


func add_to_plate(veg: Node3D, player_inventory):
	if veg!= null and Global.Platelist.has(veg.name):
		held_vegetables.append(veg.name)
		veg.queue_free()
		var newveg = Global.VegDictionary.get(veg.name).instantiate()
		add_child(newveg)
		var offset = Vector3(0, 0.1 + 0.2 * held_vegetables.size(), 0)
		newveg.freeze = true
		newveg.get_node("CollisionShape3D").disabled = true
		newveg.transform.origin = offset
func add_vegetable(veg: Node3D,player_inventory):
	if Global.Platelist.has(veg.name):
		held_vegetables.append(veg.name)
		var newveg = Global.VegDictionary.get(veg.name).instantiate()
		player_inventory.deletehelditem()
		add_child(newveg)
		var offset = Vector3(0, 0.1 + 0.2 * held_vegetables.size(), 0)
		newveg.freeze = true
		newveg.get_node("CollisionShape3D").disabled = true
		newveg.transform.origin = offset
func clear_plate():
	if held_vegetables.size() > 0:
		for child in get_children():
			if !childlist.has(child.name):
				child.queue_free()
		held_vegetables.clear()


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
