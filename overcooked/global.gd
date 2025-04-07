extends Node3D

var VegDictionary = {
	"Tomato" : preload("res://Objects/Food preloads/Tomato.tscn"),
	"Fish" : preload("res://Objects/Food preloads/Fish.tscn"),
	"Onion" : preload("res://Objects/Food preloads/Onion.tscn"),
	"Mushroom" : preload("res://Objects/Food preloads/Mushroom.tscn"),
	"Lettuce" : preload("res://Objects/Food preloads/Lettuce.tscn"),
	"Meat" : preload("res://Objects/Food preloads/Meat.tscn"),
	"Plate" : preload("res://Plate.tscn")
	}
var Veglist = VegDictionary.keys()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
