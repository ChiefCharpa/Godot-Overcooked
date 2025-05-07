extends Node3D

var VegDictionary = {
	"Bun" : preload("res://Objects/Food preloads/Raw/Bun.tscn"),
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
	"Cooked_Meat" : preload("res://Objects/Food preloads/Cooked/Cooked_Meat.tscn"),
	"Soup_Tomato" : preload("res://Objects/Food preloads/Soup/Soup_Tomato.tscn"),
	"Soup_Onion" : preload("res://Objects/Food preloads/Soup/Soup_Onion.tscn"),
	"Soup_Mushroom" : preload("res://Objects/Food preloads/Soup/Soup_Mushroom.tscn"),
	"Burger" : preload ("res://Overcooked Assets/Food/Burgers/Burger(Plain).glb"),
	"Burger+Lettuce" : preload("res://Overcooked Assets/Food/Burgers/Burger(Lettuce).glb"),
	"Burger+Lettuce+Tomato" : preload("res://Overcooked Assets/Food/Burgers/Burger(TomatoAndLettuce).glb"),
	"Burger+Tomato" : preload("res://Overcooked Assets/Food/Burgers/Burger(Tomato).glb"),
	"Burnt_Meat" : preload("res://Objects/Food preloads/Cooked/Burnt_meat.tscn"),
	"Burnt_Fish" : preload("res://Objects/Food preloads/Cooked/Burnt_Fish.tscn"),
	"Burnt_Soup" : preload("res://Objects/Food preloads/Soup/Burnt_Soup.tscn"),
	"Salad" : preload("res://Overcooked Assets/Food/Salad/SaladPlain.glb"),
	"Salad+Tomato" : preload("res://Overcooked Assets/Food/Salad/SaladTomato.glb")

	}
var Veglist = VegDictionary.keys()
var Platelist = ["Chopped_Tomato","Chopped_Onion","Chopped_Mushroom","Chopped_Lettuce","Cooked_Fish","Cooked_Meat","Soup_Tomato","Soup_Mushroom","Soup_Onion","Bun"]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
