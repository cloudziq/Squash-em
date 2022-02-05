extends Control


var score




func on_new_game():
	score = 0
	$ScoreLabel.hide()
	yield(get_tree().create_timer(1), "timeout")
	$ScoreLabel.show()
	$Message.hide()




func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()


func _on_MessageTimer_timeout():
	$Message.hide()


func _on_Player_score_change():
	score += 1
	$ScoreLabel.text = "SCORE:  "+ str(score)
