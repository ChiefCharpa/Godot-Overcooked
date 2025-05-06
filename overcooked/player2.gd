extends CharacterBody3D

const SPEED = 5.0
const DASH_MULTIPLIER = 2.5
const GRAVITY = 2.0
const DASH_DURATION = 0.3  # Dash lasts 0.3 seconds

var freeze: bool = false
var dashing: bool = false
var dash_timer: float = 0.0
var last_direction: Vector3 = Vector3.ZERO

@onready var inventory: Inventory2 = $Inventory

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("print_inventory"):
		print("Current Inventory:", inventory.resources_inventory)

	if Input.is_action_just_pressed("Dash2") and last_direction != Vector3.ZERO and not dashing:
		dashing = true
		dash_timer = DASH_DURATION

func _physics_process(delta: float) -> void:
	var input_dir = Input.get_vector("Left2", "Right2", "Forwards2", "Backwards2")
	var move_dir = Vector3(input_dir.x, 0, input_dir.y).normalized()

	# Apply gravity
	velocity.y -= GRAVITY

	if not freeze:
		if move_dir != Vector3.ZERO:
			last_direction = move_dir  # Update direction only when there's movement

		if dashing:
			velocity.x = last_direction.x * SPEED * DASH_MULTIPLIER
			velocity.z = last_direction.z * SPEED * DASH_MULTIPLIER

			dash_timer -= delta
			if dash_timer <= 0.0:
				dashing = false  # End dash
		elif move_dir != Vector3.ZERO:
			velocity.x = move_dir.x * SPEED
			velocity.z = move_dir.z * SPEED
		else:
			velocity.x = 0
			velocity.z = 0

		# Smooth rotation toward last direction
		var target_rotation = atan2(-last_direction.x, -last_direction.z)
		rotation.y = lerp_angle(rotation.y, target_rotation, 0.2)

	move_and_slide()

func Freeze():
	freeze = not freeze
	print("freeze" if freeze else "unfreeze")
