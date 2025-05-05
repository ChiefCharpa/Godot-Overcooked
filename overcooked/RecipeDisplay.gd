extends Control

const UI_RECIPE_DISPLAY = preload("res://ui_recipe_display.tscn")
@export var recipeSpacing := 3 # Space between 'slots'
@export var recipeWidth := 300 # A Base measure for how wide each recipe 'slot' is

var slideDur := 2.0
var endPos : Vector2
var displayedRecipes : Array = []

# Sets which recipe to display
func recipeImage(image : Texture2D):
	$TextureRect.texture =  image

# Moves recipe over to where the recipe should be positioned 
func positioning(pos : Vector2):
	endPos = pos
	var transition = create_tween()
	transition.tween_property(self, "position", endPos, slideDur).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

# Displays recipe by instantiating it in the top right and then sliding it to the position it should be in
func displayRecipe(image : Texture2D):
	var recipeSlot = UI_RECIPE_DISPLAY.instantiate()
	add_child(recipeSlot)
	recipeSlot.recipeImage(image)
	recipeWidth = recipeSlot.size.x
	
	var spawnPoint = Vector2(get_viewport_rect().size.x + 200, 0) # Spawn Pos
	recipeSlot.position = spawnPoint
	var slotIndex = displayedRecipes.size()
	
	var temp = 0
	for i in displayedRecipes: # Calculating End Pos (x)
		temp += i.size.x + recipeSpacing
	var endPos = Vector2((temp), 0) # End Pos
	
	recipeSlot.positioning(endPos)
	displayedRecipes.append(recipeSlot)
