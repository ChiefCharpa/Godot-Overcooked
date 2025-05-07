extends TextureRect
var score

func displayStars():
	score = get_node("../../StatDisplay/Score").totalScore
	
	if score < 20:
		self.texture = load("res://UI/Results/0 Stars.png")
	if score >= 20:
		self.texture = load("res://UI/Results/1 Stars.png")
	if score >= 30:
		self.texture = load("res://UI/Results/2 Stars.png")
	if score >= 40:
		self.texture = load("res://UI/Results/3 Stars.png")
		
	
