extends Control

func buttonPressed():
	$"../ControlDisplay".displayControls()

func _ready():
	self.pressed.connect(buttonPressed)
