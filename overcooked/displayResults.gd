extends Control
var resultsVisible = false

func _ready():
	self.visible = false

func makeVisible():
	resultsVisible = true
	self.visible = true
