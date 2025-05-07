extends RigidBody3D

var player_inventory = null
var resource_type = "Plate"
var foam = preload("res://Foam.tscn")
var sprayPoint
var timer
var foamTime: CPUParticles3D;

@onready var spray_cooldown = $SprayCooldown

func _ready() -> void:
	sprayPoint = get_node("SprayPoint")


func _process(delta):
	if spray_cooldown.is_stopped():
		self.get_child(5).emitting = false;
		

func _activate(player_inventory):
	pass

func pickup(player_inventory):
	player_inventory.add_container(self)

func get_some_variable():
	return resource_type

func spray_foam():
	if spray_cooldown.is_stopped():
		var foam_instance = foam.instantiate()
		get_tree().current_scene.add_child(foam_instance)
		foam_instance.global_transform.origin = sprayPoint.global_transform.origin
		var direction = -sprayPoint.global_transform.basis.z.normalized()
		foam_instance.linear_velocity = direction * 10
		self.get_child(5).emitting = true;
		spray_cooldown.start(0.05)  # Wait 0.05 seconds before allowing another spray
