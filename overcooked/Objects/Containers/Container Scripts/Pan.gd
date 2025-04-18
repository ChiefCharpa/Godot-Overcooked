extends RigidBody3D

var resource_type
var held_vegetable = null
var veg
var cooking = false
var onstove = false
@onready var timer =	$Timer 

func _ready():
	self.freeze = true
	resource_type = "Plate" # Define the plate as a container

func add_vegetable(veg: Node3D,player_inventory):
	var parts = veg.name.split("_")
	if Global.Veglist.has("Cooked_"+parts[-1]) and veg.name.begins_with("Chopped") and held_vegetable == null:
		held_vegetable = veg.name
		var newveg = Global.VegDictionary.get(veg.name).instantiate()
		player_inventory.deletehelditem()
		add_child(newveg)
		var offset = Vector3(0, 0.05, 0)
		newveg.freeze = true
		newveg.get_node("CollisionShape3D").disabled = true
		newveg.transform.origin = offset
		if onstove == true:
			cook()
func take_from_pan():
	if held_vegetable != null:
		for child in get_children():
				if child.name == held_vegetable:
					var returnchild = child
					clear_plate()
					return returnchild
func clear_plate():
	if held_vegetable != null:
		for child in get_children():
				if child.name == held_vegetable:
					child.queue_free()
					held_vegetable = null
func cook():
	var cook = false
	for child in self.get_children():
		if Global.Veglist.has(child.name):
			veg = child
			cook = true
	if cook and not cooking:
		print("cooking")
		cooking = true
		timer.start()
	elif cook and cooking:
		print("Not cooking")
		cooking = false
		timer.wait_time = timer.time_left
		timer.stop()

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
func ispan():
	pass


func _on_timer_timeout():
	var cooked_key = "Cooked_"+veg.name.split("_")[1]
	var cooked_veg =  Global.VegDictionary[cooked_key].instantiate()
	cooked_veg.name = cooked_key
	add_child(cooked_veg)
	held_vegetable = cooked_veg.name
	cooked_veg.transform.origin = Vector3(0, 0.05, 0)
	cooked_veg.freeze = true
	cooked_veg.get_node("CollisionShape3D").disabled = true
	veg.queue_free()
	timer.stop()
	timer.wait_time = 10
	cooking = false
