extends Control
var GameScene1 = preload("res://Level.tscn")
var GameScene2 = preload("res://level_2.tscn")
var GameScene3 = preload("res://level.tscn")
func buttonPressed():
	$"../ControlDisplay".displayControls()

func _ready():
	self.pressed.connect(buttonPressed)


func _on_level_1_pressed() -> void:
	get_tree().change_scene_to_packed(GameScene1)


func _on_level_2_pressed() -> void:
	get_tree().change_scene_to_packed(GameScene2)


func _on_level_3_pressed() -> void:
	get_tree().change_scene_to_packed(GameScene3)
