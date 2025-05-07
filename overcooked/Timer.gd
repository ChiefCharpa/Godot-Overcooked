extends Node

@export var levelDuration := 150
var timeLeft := 0.0
var timerOn := false;

@onready var recipe_display: Control = get_node("../../RecipeDisplay")

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
	get_node("../../ResultsDisplay/ScoreText").displayResultScore()
	get_node("../../ResultsDisplay").makeVisible()
	get_node("../../ResultsDisplay/Stars").displayStars()
	print("Level end")

func _ready() -> void:
	startTimer(levelDuration)
	$"../Score".resetScore() # Sets score to 0 at start of level
	
	#var recipeTexture = load("res://UI/Recipes/Burgers/Recipe_Burger_4.png")
	#recipe_display.displayRecipe(recipeTexture)

func _process(delta):
	if timerOn == true:
		timeLeft -= delta # Counts down the timer
		if timeLeft <= 0: # Checks for timer running out
			timerOn = false
			finishTimer()
		else:
			updateTimer(timeLeft)
