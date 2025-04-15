extends Node3D

var VegDictionary = {
	"Tomato" : preload("res://Objects/Food preloads/Raw/Tomato.tscn"),
	"Fish" : preload("res://Objects/Food preloads/Raw/Fish.tscn"),
	"Onion" : preload("res://Objects/Food preloads/Raw/Onion.tscn"),
	"Mushroom" : preload("res://Objects/Food preloads/Raw/Mushroom.tscn"),
	"Lettuce" : preload("res://Objects/Food preloads/Raw/Lettuce.tscn"),
	"Meat" : preload("res://Objects/Food preloads/Raw/Meat.tscn")
}
var choppedVegDictionary = {
	"Chopped_Tomato" : preload("res://Objects/Food preloads/Chopped/Chopped_Tomato.tscn"),
	"Chopped_Fish" : preload("res://Objects/Food preloads/Chopped/Chopped_Fish.tscn"),
	"Chopped_Onion" : preload("res://Objects/Food preloads/Chopped/Chopped_Onion.tscn"),
	"Chopped_Mushroom" : preload("res://Objects/Food preloads/Chopped/Chopped_Mushroom.tscn"),
	"Chopped_Lettuce" : preload("res://Objects/Food preloads/Chopped/Chopped_Lettuce.tscn"),
	"Chopped_Meat" : preload("res://Objects/Food preloads/Chopped/Chopped_Meat.tscn")
}
var Veglist = VegDictionary.keys()
var choppedVeglist = choppedVegDictionary.keys()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
