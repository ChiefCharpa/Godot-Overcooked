extends RichTextLabel
var score

func displayResultScore():
	score = get_node("../../StatDisplay/Score").totalScore
	self.text = str(score)
