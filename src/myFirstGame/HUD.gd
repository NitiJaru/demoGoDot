extends CanvasLayer

signal start_game

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func show_message(text):
    $MessageLabel.text = text
    $MessageLabel.show()
    $MessageTimer.start()

func show_game_over():
    Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
    show_message("Game Over")
    yield($MessageTimer, "timeout")
    $StartButton.show()
    $MessageLabel.text = "Dodge the\nCreeps!"
    $MessageLabel.show()

func update_score(score):
    $ScoreLabel.text = str(score)

func _on_StartButton_pressed():
    $StartButton.hide()
    emit_signal("start_game")	
    $ButtonSound.play()
    Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
    pass # replace with function body

func _on_MessageTimer_timeout():
    $MessageLabel.hide()
    pass # replace with function body