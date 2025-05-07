extends Control
var resultsVisible = false

func _ready():
	self.visible = false

func makeVisible():
	resultsVisible = true
	self.visible = true


func _on_quit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Main menu.tscn")
