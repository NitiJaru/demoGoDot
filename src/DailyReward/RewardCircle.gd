extends Area2D

signal finishplay

func _ready():
	$Unselect.show()
	$Selected.hide()
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _playanimation():
	$Unselect.hide()
	$Selected.show()
	$PlayTimer.start()

func _on_PlayTimer_timeout():
	$Unselect.show()
	$Selected.hide()
	emit_signal("finishplay")
	pass # replace with function body
