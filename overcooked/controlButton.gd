extends Control
var GameScene1 = preload("res://Level_1.tscn")
var GameScene2 = preload("res://level_2.tscn")
var GameScene3 = preload("res://Level3.tscn")
var GameScene4 = preload("res://level_4.tscn")
var target_child
func buttonPressed():
	$"../ControlDisplay".displayControls()

func _ready():
	target_child = get_parent().get_node("coop/Level4Texture")
	self.pressed.connect(buttonPressed)


func _on_level_1_pressed() -> void:
	get_tree().change_scene_to_packed(GameScene1)


func _on_level_2_pressed() -> void:
	get_tree().change_scene_to_packed(GameScene2)


func _on_level_3_pressed() -> void:
	get_tree().change_scene_to_packed(GameScene3)

func _on_level_4_pressed() -> void:
	get_tree().change_scene_to_packed(GameScene4)


func _on_coop_pressed() -> void:
	Global.coop = not Global.coop
	if Global.coop == true:
		target_child.modulate = Color(0, 1, 0)  # Green
	else:
		target_child.modulate = Color(1, 0, 0)  # Default (white)

	print(Global.coop)
