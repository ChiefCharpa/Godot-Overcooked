extends Node


@export var levelDuration := 90
var timeLeft := 0.0
var timerOn := false;

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

func _process(delta):
	if timerOn == true:
		timeLeft -= delta # Counts down the timer
		
		if timeLeft <= 0: # Checks for timer running out
			timerOn = false
			finishTimer()
		else:
			updateTimer(timeLeft)
