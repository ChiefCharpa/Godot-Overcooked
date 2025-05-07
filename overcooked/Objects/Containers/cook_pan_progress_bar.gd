extends Node3D

@onready var barFill := $ProgressBarFill
@onready var barRoot := self
var cookingTime := 5.0
var cookingProgress := 0.0
var cooking := false

func doCooking():
	resumeCooking()
	cooking = true
	barRoot.visible = true
	set_process(true)
func pauseCooking():
	cooking = false
	barRoot.visible = false
	set_process(false)
func resumeCooking():
	cooking = true
	barRoot.visible = true
	set_process(true)

func _ready():
	barRoot.visible = false

func _process(delta):
	if cooking:
		cookingProgress += delta
		var ratiod = clamp(cookingProgress / cookingTime, 0, 1)
		barFill.scale.x = 1.0 - ratiod  # Gets smaller

		# Cooking done
		if cookingProgress >= cookingTime:
			cooking = false
			barRoot.visible = false
			set_process(false)
		if barRoot:
			barRoot.global_rotation = Vector3(0, 0, 0) # Always faces the camera
