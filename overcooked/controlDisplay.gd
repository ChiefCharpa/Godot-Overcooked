extends TextureRect

var index := 0

func displayControls():
	index += 1
	if index == 1:
		self.texture = load("res://UI/Controls/Controls_Controller_Solo.png")
	elif index == 2:
		self.texture = load("res://UI/Controls/Controls_Keyboard_Solo.png")
	elif index == 3:
		self.texture = load("res://UI/Controls/Controls_Controller_Split.png")
	elif index == 4:
		self.texture = load("res://UI/Controls/Controls_Keyboard_Split.png")
		index = 0
