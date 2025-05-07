extends Node3D
@onready var sprite1: Sprite3D = $vegDisplay1
@onready var sprite2: Sprite3D = $vegDisplay2
@onready var sprite3: Sprite3D = $vegDisplay3
var mushroomTex = preload("res://UI/Ingredients/Ingredient_Mushroom.png")
var onionTex = preload("res://UI/Ingredients/Ingredient_Onion.png")
var tomatoTex = preload("res://UI/Ingredients/Ingredient_Tomato.png")
var potList: Array = []

func addVegTex(heldVeg):
	potList = heldVeg
	sprite1.scale = Vector3(0.025, 0.05, 0.025)
	sprite2.scale = Vector3(0.025, 0.05, 0.025)
	sprite3.scale = Vector3(0.025, 0.05, 0.025)
	if potList.size() == 1:
		sprite1.visible = true
		if heldVeg[0] == "Chopped_Mushroom":
			sprite1.texture = mushroomTex
		if heldVeg[0] == "Chopped_Onion":
			sprite1.texture = onionTex
		if heldVeg[0] == "Chopped_Tomato":
			sprite1.texture = tomatoTex
	if potList.size() == 2:
		sprite2.visible = true
		if heldVeg[1] == "Chopped_Mushroom":
			sprite2.texture = mushroomTex
		if heldVeg[1] == "Chopped_Onion":
			sprite2.texture = onionTex
		if heldVeg[1] == "Chopped_Tomato":
			sprite2.texture = tomatoTex
	if potList.size() == 3:
		sprite3.visible = true
		if heldVeg[2] == "Chopped_Mushroom":
			sprite3.texture = mushroomTex
		if heldVeg[2] == "Chopped_Onion":
			sprite3.texture = onionTex
		if heldVeg[2] == "Chopped_Tomato":
			sprite3.texture = tomatoTex

func emptyPot():
	potList = []
	sprite1.visible = false
	sprite2.visible = false
	sprite3.visible = false
