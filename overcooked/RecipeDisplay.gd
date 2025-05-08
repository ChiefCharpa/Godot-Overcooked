extends Control

const UI_RECIPE_DISPLAY = preload("res://ui_recipe_display.tscn")
@onready var progressBar = $ProgressBar
@export var recipeSpacing := 3 # Space between 'slots'
@export var recipeWidth := 300 # A Base measure for how wide each recipe 'slot' is
@export var recipeTimer := 60.0 # Expiration timer
signal recipeExpired(recipe : Node)
var timeLeft := 0.0

var slideDur := 2.0
var endPos : Vector2
var displayedRecipes : Array = []

# Progress bar display and count-down
func _ready():
	timeLeft = recipeTimer
	progressBar.max_value = recipeTimer
	progressBar.value = timeLeft
	set_process(true)
	
func _process(delta):
	timeLeft -= delta
	progressBar.value = timeLeft
	if timeLeft <= 0:
		recipeExpired.emit(self) # kill self
		set_process(false)

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
	
	recipeSlot.get_node("ProgressBar").show()
	
	var spawnPoint = Vector2(get_viewport_rect().size.x + 200, 0)
	recipeSlot.position = spawnPoint
	var slotIndex = displayedRecipes.size()
	var endPos = Vector2((recipeWidth + recipeSpacing) * slotIndex, 0)
	
	recipeSlot.positioning(endPos)
	displayedRecipes.append(recipeSlot)

# Destroys recipe and moves the others to take its place
func destroyRecipe():
	var recipe = displayedRecipes[0]
	displayedRecipes.remove_at(0)
	

	for i in range(0, displayedRecipes.size()):
		var newPos = Vector2((recipeWidth + recipeSpacing) * i, 0)
		displayedRecipes[i].positioning(newPos)
		
	recipe.queue_free()
