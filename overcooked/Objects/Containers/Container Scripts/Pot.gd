extends RigidBody3D

var resource_type
var held_vegetable: Array = []
var veg
var cooking = false
var onstove = false
var partial = false
@onready var timer =$Timer 
@onready var mesh = $MeshInstance3D3
@onready var camera = get_node("/root/LevelNode/Camera3D")

func _ready():
	self.freeze = true
	resource_type = "Plate" # Define the plate as a container

func add_vegetable(veg: Node3D,player_inventory):
	var parts = veg.name.split("_")
	if Global.Veglist.has("Soup_"+parts[-1]) and veg.name.begins_with("Chopped") and held_vegetable.size()<3:
		held_vegetable.append(veg.name)
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
	if held_vegetable != [] and held_vegetable[0].begins_with("Soup") and held_vegetable[0]:
		for child in get_children():
				if child.name == held_vegetable[0]:
					var returnchild = child
					clear_plate()
					partial = false
					return returnchild
func clear_plate():
	if held_vegetable != []:
		for child in get_children():
			for veg in held_vegetable:
				if child.name == veg:
					child.queue_free()
					held_vegetable = []
func cook():
	var cook = false
	for child in self.get_children():
		if Global.Veglist.has(child.name):
			veg = child
			cook = true
	if cook and onstove:
		print("cooking")
		cooking = true
		if timer.is_stopped() and not partial : #if timer is stopped and nothing has been cooked
			timer.wait_time = 5*held_vegetable.size()
			timer.start()
			partial = true
		elif timer.is_stopped() and partial: #if timer is stopped and something has been cooked
			print("wait timer is ", timer.wait_time)
			for veg in held_vegetable:
				if veg.begins_with("Chopped"):
					timer.wait_time +=5
			timer.wait_time -= 5
			timer.start()
		elif not timer.is_stopped(): #if timer is running
			timer.timer_left += 5
	elif cook and not onstove:
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
func ispot():
	pass
func ispan():
	pass


func _on_timer_timeout():
	var temp = held_vegetable.duplicate()
	for veg in temp:
		print(veg)
		var cooked_key = "Soup_"+veg.split("_")[1]
		var cooked_veg =  Global.VegDictionary[cooked_key].instantiate()
		add_child(cooked_veg)
		cooked_veg.name = cooked_key
		held_vegetable.erase(veg)
		held_vegetable.append("Soup_"+veg.split("_")[1])
		cooked_veg.transform.origin = Vector3(0, 0.05, 0)
		cooked_veg.freeze = true
		cooked_veg.get_node("CollisionShape3D").disabled = true
		timer.stop()
		timer.wait_time = 5
		cooking = false
		print(held_vegetable)
