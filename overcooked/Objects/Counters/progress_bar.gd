extends Node3D

@onready var barFill := $ProgressBarFill
@onready var barRoot := self
var choppingTime := 6.0
var choppingProgress := 0.0
var chopping := false

func doChopping():
	resumeChopping()
	chopping = true
	barRoot.visible = true
	set_process(true)
func pauseChopping():
	chopping = false
	barRoot.visible = false
	set_process(false)
func resumeChopping():
	chopping = true
	barRoot.visible = true
	set_process(true)

func _ready():
	barRoot.visible = false

func _process(delta):
	if chopping:
		choppingProgress += delta
		var ratiod = clamp(choppingProgress / choppingTime, 0, 1)
		barFill.scale.x = 1.0 - ratiod  # Gets smaller

		# Chopping done
		if choppingProgress >= choppingTime:
			chopping = false
			barRoot.visible = false
			set_process(false)
		if barRoot:
			barRoot.global_rotation = Vector3(0, 0, 0) # Always faces the camera
