extends CanvasLayer

signal start_game

func update_score(value):
	$MarginContainer/ScoreLabel.text = str(value)

func update_timer(value):
	if len(str(value)) == 1:
		$MarginContainer/TimeLabel.text = "0: 0" + str(value)
	else:
		$MarginContainer/TimeLabel.text = "0: " + str(value)
	
func update_level(value):
	$MarginContainer/LevelLabel.text = "LEVEL: " + str(value)

func show_message(text):
	$ColorRect.show()
	$ColorRect/Message.text = text
	#$ColorRect/Message.show()
	$MessageTimer.start()

func _on_Button_pressed():
	$ColorRect.hide()
	$ColorRect/StartButton.hide()
	#$Message.hide()
	emit_signal("start_game")
	
func show_game_over():
	show_message("GAME OVER")
	yield($MessageTimer, "timeout")
	$ColorRect/StartButton.show()
	$ColorRect/Message.text = "COD #13: BAD EXPERIMENT"
	$ColorRect/Message.show()

func _on_MessageTimer_timeout():
	$ColorRect/Message.hide()