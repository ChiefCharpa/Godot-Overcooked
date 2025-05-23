extends Area3D

var cleanPlates
var burning = false
func get_plate_count() -> int:
	var count = 0
	var parent_node = get_parent()
	if parent_node:
		for sibling in parent_node.get_children():
			if sibling.name.begins_with("Plate"):
				count += 1
	return count



func spawnPlate():
	var plate_count = get_plate_count()  # Get count before spawning

	var plate_obj = Global.VegDictionary["Plate"].instantiate()
	plate_obj.name = "Plate_" + str(plate_count + 1)
	plate_obj.freeze = true
	
	# Position the new plate
	var vertical_offset = 0.1 * plate_count + 0.4
	plate_obj.global_transform.origin = Vector3(0, vertical_offset, .7)

	get_parent().add_child(plate_obj)  # Add after it's positioned

	print("Spawned plate at height:", vertical_offset)
func onFire():
	burning = true
	var fire = preload("res://Fire.tscn").instantiate()
	add_child(fire)
	fire.transform.origin = Vector3(0, 1, 0)
