extends Control
var GameScene1 = preload("res://Level_1.tscn")
var GameScene2 = preload("res://level_2.tscn")
var GameScene3 = preload("res://Level3.tscn")
var GameScene4 = preload("res://level_4.tscn")
func buttonPressed():
	$"../ControlDisplay".displayControls()
	$"ButtonSFX".play()

func _ready():
	self.pressed.connect(buttonPressed)


func _on_level_1_pressed() -> void:
	$"ButtonSFX".play()
	get_tree().change_scene_to_packed(GameScene1)


func _on_level_2_pressed() -> void:
	$"ButtonSFX".play()
	get_tree().change_scene_to_packed(GameScene2)


func _on_level_3_pressed() -> void:
	$"ButtonSFX".play()
	get_tree().change_scene_to_packed(GameScene3)

func _on_level_4_pressed() -> void:
	$"ButtonSFX".play()
	get_tree().change_scene_to_packed(GameScene4)


func _on_coop_pressed() -> void:
	$"ButtonSFX".play()
	Global.coop = not Global.coop
	print(Global.coop)
