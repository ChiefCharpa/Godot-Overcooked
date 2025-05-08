extends RigidBody3D

var resource_type
var held_vegetables: Array = []
var childlist: Array = []

func _ready():
	self.freeze = true
	resource_type = "Plate" # Define the plate as a container
	for child in get_children():
		childlist.append(child.name)

func add_to_plate(veg: Node3D):
	if veg!= null and Global.Platelist.has(veg.name):
		held_vegetables.append(veg.name)
		veg.queue_free()
		var newveg = Global.VegDictionary.get(veg.name).instantiate()
		add_child(newveg)
		var offset = Vector3(0, 0.1 + 0.2 * held_vegetables.size(), 0)
		newveg.freeze = true
		newveg.get_node("CollisionShape3D").disabled = true
		newveg.transform.origin = offset
		BurgerCheck()

func add_vegetable(veg: Node3D,player_inventory):
	print(veg.name)
	if Global.Platelist.has(veg.name):
		held_vegetables.append(veg.name)
		var newveg = Global.VegDictionary.get(veg.name).instantiate()
		player_inventory.deletehelditem()
		add_child(newveg)
		var offset = Vector3(0, 0.1 * held_vegetables.size(), 0)
		newveg.freeze = true
		newveg.get_node("CollisionShape3D").disabled = true
		newveg.transform.origin = offset
		BurgerCheck()
func clear_plate():
	if held_vegetables.size() > 0:
		for child in get_children():
			if !childlist.has(child.name):
				child.queue_free()
		held_vegetables.clear()

func delete_child(deletechild: String):
	for child in self.get_children():
		print(child.name)
		if child.name == deletechild:
			child.queue_free()

func BurgerCheck(): #dont look at this
		#meat line
		if held_vegetables.has("Bun") and held_vegetables.has("Cooked_Meat"):
			clear_plate()
			held_vegetables.append("Burger")
			var newveg = Global.VegDictionary.get("Burger").instantiate()
			add_child(newveg)
			var offset = Vector3(0, 0.1 + 0.2 * held_vegetables.size(), 0)
			newveg.transform.origin = offset
		if held_vegetables.has("Burger") and held_vegetables.has("Chopped_Tomato"):
			clear_plate()
			held_vegetables.append("Burger+Tomato")
			var newveg = Global.VegDictionary.get("Burger+Tomato").instantiate()
			add_child(newveg)
			var offset = Vector3(0, 0.1 + 0.2 * held_vegetables.size(), 0)
			newveg.transform.origin = offset
		if held_vegetables.has("Burger") and held_vegetables.has("Chopped_Lettuce"):
			clear_plate()
			held_vegetables.append("Burger+Lettuce")
			var newveg = Global.VegDictionary.get("Burger+Lettuce").instantiate()
			add_child(newveg)
			var offset = Vector3(0, 0.1 + 0.2 * held_vegetables.size(), 0)
			newveg.transform.origin = offset
		#tomato line
		if held_vegetables.has("Bun") and held_vegetables.has("Chopped_Tomato"):
			clear_plate()
			held_vegetables.append("BurgerTNM")
			var newveg = Global.VegDictionary.get("BurgerTNM").instantiate()
			add_child(newveg)
			var offset = Vector3(0, 0.1 + 0.2 * held_vegetables.size(), 0)
			newveg.transform.origin = offset
		if held_vegetables.has("Chopped_Lettuce") and held_vegetables.has("BurgerTNM"):
			clear_plate()
			held_vegetables.append("BurgerTLNM")
			var newveg = Global.VegDictionary.get("BurgerTLNM").instantiate()
			add_child(newveg)
			var offset = Vector3(0, 0.1 + 0.2 * held_vegetables.size(), 0)
			newveg.transform.origin = offset
		if held_vegetables.has("Cooked_Meat") and held_vegetables.has("BurgerTNM"):
			clear_plate()
			held_vegetables.append("Burger+Tomato")
			var newveg = Global.VegDictionary.get("Burger+Tomato").instantiate()
			add_child(newveg)
			var offset = Vector3(0, 0.1 + 0.2 * held_vegetables.size(), 0)
			newveg.transform.origin = offset
		if held_vegetables.has("Chopped_Lettuce") and held_vegetables.has("Burger+Tomato"):
			clear_plate()
			held_vegetables.append("Burger+Lettuce+Tomato")
			var newveg = Global.VegDictionary.get("Burger+Lettuce+Tomato").instantiate()
			add_child(newveg)
			var offset = Vector3(0, 0.1 + 0.2 * held_vegetables.size(), 0)
			newveg.transform.origin = offset
		#lettuce line
		if held_vegetables.has("Bun") and held_vegetables.has("Chopped_Lettuce"):
			clear_plate()
			held_vegetables.append("BurgerLNM")
			var newveg = Global.VegDictionary.get("BurgerLNM").instantiate()
			add_child(newveg)
			var offset = Vector3(0, 0.1 + 0.2 * held_vegetables.size(), 0)
			newveg.transform.origin = offset
		if held_vegetables.has("Chopped_Tomato") and held_vegetables.has("BurgerLNM"):
			clear_plate()
			held_vegetables.append("BurgerTLNM")
			var newveg = Global.VegDictionary.get("BurgerTLNM").instantiate()
			add_child(newveg)
			var offset = Vector3(0, 0.1 + 0.2 * held_vegetables.size(), 0)
			newveg.transform.origin = offset
		if held_vegetables.has("Cooked_Meat") and held_vegetables.has("BurgerLNM"):
			clear_plate()
			held_vegetables.append("Burger+Lettuce")
			var newveg = Global.VegDictionary.get("Burger+Lettuce").instantiate()
			add_child(newveg)
			var offset = Vector3(0, 0.1 + 0.2 * held_vegetables.size(), 0)
			newveg.transform.origin = offset
		if held_vegetables.has("Cooked_Meat") and held_vegetables.has("BurgerTLNM"):
			clear_plate()
			held_vegetables.append("Burger+Lettuce+Tomato")
			var newveg = Global.VegDictionary.get("Burger+Lettuce+Tomato").instantiate()
			add_child(newveg)
			var offset = Vector3(0, 0.1 + 0.2 * held_vegetables.size(), 0)
			newveg.transform.origin = offset
		if held_vegetables.has("Chopped_Tomato") and held_vegetables.has("Burger+Lettuce"):
			clear_plate()
			held_vegetables.append("Burger+Lettuce+Tomato")
			var newveg = Global.VegDictionary.get("Burger+Lettuce+Tomato").instantiate()
			add_child(newveg)
			var offset = Vector3(0, 0.1 + 0.2 * held_vegetables.size(), 0)
			newveg.transform.origin = offset
			#salad stuff
		if !held_vegetables.has("Buns") and held_vegetables.has("Chopped_Lettuce"):
			held_vegetables.erase(&"Chopped_Lettuce")
			held_vegetables.append("Salad")
			delete_child("Chopped_Lettuce")
			var newveg = Global.VegDictionary.get("Salad").instantiate()
			add_child(newveg)
			var offset = Vector3(0, 0.2 * held_vegetables.size(), 0)
			newveg.transform.origin = offset
		if held_vegetables.has("Salad") and held_vegetables.has("Chopped_Tomato"):
			held_vegetables.erase(&"Chopped_Tomato")
			held_vegetables.erase("Salad")
			held_vegetables.append(("Salad+Tomato"))
			delete_child("Chopped_Tomato")
			delete_child("SaladPlain")
			var newveg = Global.VegDictionary.get("Salad+Tomato").instantiate()
			add_child(newveg)
			var offset = Vector3(0,0.2 * held_vegetables.size(), 0)
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
	
func cleanPlate():
	pass
