extends Control

@export var recipeScene : PackedScene
@export var recipeSpacing := 10 # Space between 'slots'
@export var recipeWidth := 150 # How wide each recipe 'slot' is

var slideDur := 0.5
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
	var recipeSlot = recipeScene.instantiate()
	add_child(recipeSlot)
	recipeSlot.recipeImage(image)
	var spawnPoint = Vector2(size.x, 10)
	recipeSlot.position = spawnPoint
	var slotIndex = displayedRecipes.size()
	var endPos = Vector2(size.x - ((recipeWidth + recipeSpacing) * (slotIndex + 1)), 10)
	
	recipeSlot.positioning(endPos)
	displayedRecipes.append(recipeSlot)
