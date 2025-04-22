extends RigidBody3D
var resource_type = "Interactable"
@onready var order_Timer = $plate_Timer

func _ready() -> void:
	await get_tree().process_frame
	self.freeze = true

func start_random_timer():
	print("b")
	var new_time = randf_range(5.0, 10.0)
	order_Timer.wait_time = new_time
	order_Timer.start()

func spawn():
	print("a")
	start_random_timer()

func _activate():
		spawn()
		
func get_some_variable():
	return resource_type


func _on_plate_timer_timeout() -> void:
	print("c")
	var spawnedplate = Global.VegDictionary.get("Plate").instantiate()
	spawnedplate.global_position = self.global_position + Vector3(0,0.6,0.8)
	get_parent().get_parent().add_child(spawnedplate)
