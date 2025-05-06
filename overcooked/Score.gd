extends TextureRect
var totalScore

func addScore(score):
	totalScore += score
	get_node("ScoreText").text = str(totalScore)

func resetScore():
	totalScore = 0
