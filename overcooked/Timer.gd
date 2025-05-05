extends Node

@export var levelDuration := 90
var timeLeft := 0.0
var timerOn := false;

@onready var recipe_display: Control = $"../../RecipeDisplay"

# Update timer display
func updateTimer(timeLeft : float):
	var mins = int(timeLeft) / 60 
	var secs = int(timeLeft) % 60
	var timeFormat = "%02d:%02d" % [mins, secs]		# XX:XX format for display
	
	get_node("TimeText").text = timeFormat

# Start timer and initialise display
func startTimer(levelDuration : float):
	timerOn = true
	timeLeft = levelDuration
	
	print("Timer started at " + str(timeLeft) + " Seconds")
	updateTimer(timeLeft)

# Finish timer (flag to end level and show results)
func finishTimer():
	# End level
	print("")

func _ready() -> void:
	startTimer(levelDuration)
	var recipeTexture = load("res://UI/Recipes/Burgers/Recipe_Burger_4.png")
	recipe_display.displayRecipe(recipeTexture)
	var time_in_seconds = 1
	await get_tree().create_timer(time_in_seconds).timeout
	recipeTexture = load("res://UI/Recipes/Burgers/Recipe_Burger_2.png")
	recipe_display.displayRecipe(recipeTexture)
	recipeTexture = load("res://UI/Recipes/Burgers/Recipe_Burger_3.png")
	recipe_display.displayRecipe(recipeTexture)

func _process(delta):
	if timerOn == true:
		timeLeft -= delta # Counts down the timer
		
		if timeLeft <= 0: # Checks for timer running out
			timerOn = false
			finishTimer()
		else:
			updateTimer(timeLeft)
