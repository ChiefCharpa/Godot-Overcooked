extends Node3D

var VegDictionary = {
	"Tomato" : preload("res://Objects/Food preloads/Raw/Tomato.tscn"),
	"Fish" : preload("res://Objects/Food preloads/Raw/Fish.tscn"),
	"Onion" : preload("res://Objects/Food preloads/Raw/Onion.tscn"),
	"Mushroom" : preload("res://Objects/Food preloads/Raw/Mushroom.tscn"),
	"Lettuce" : preload("res://Objects/Food preloads/Raw/Lettuce.tscn"),
	"Meat" : preload("res://Objects/Food preloads/Raw/Meat.tscn"),
	"Plate" : preload("res://Objects/Containers/Plate.tscn"),
	"Plate_Dirty" : preload("res://Objects/Containers/Plate_Dirty.tscn"),
	"Chopped_Tomato" : preload("res://Objects/Food preloads/Chopped/Chopped_Tomato.tscn"),
	"Chopped_Fish" : preload("res://Objects/Food preloads/Chopped/Chopped_Fish.tscn"),
	"Chopped_Onion" : preload("res://Objects/Food preloads/Chopped/Chopped_Onion.tscn"),
	"Chopped_Mushroom" : preload("res://Objects/Food preloads/Chopped/Chopped_Mushroom.tscn"),
	"Chopped_Lettuce" : preload("res://Objects/Food preloads/Chopped/Chopped_Lettuce.tscn"),
	"Chopped_Meat" : preload("res://Objects/Food preloads/Chopped/Chopped_Meat.tscn"),
	"Cooked_Fish" : preload("res://Objects/Food preloads/Cooked/Cooked_Fish.tscn"),
	"Cooked_Meat" : preload("res://Objects/Food preloads/Cooked/Cooked_Meat.tscn")
	
	}
var Veglist = VegDictionary.keys()
var Platelist = ["Chopped_Tomato","Chopped_Fish","Chopped_Onion","Chopped_Mushroom","Chopped_Lettuce","Chopped_Meat","Cooked_Fish","Cooked_Meat"]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
