extends Area2D

signal finishplay

func _ready():
	pass

func _playanimation():
	$Unselect.hide()
	$Selected.show()
	$AudioStreamPlayer2D.play()
	$PlayTimer.start()

func _on_PlayTimer_timeout():
	$Unselect.show()
	$Selected.hide()
	emit_signal("finishplay")
	pass # replace with function body

func init(url):
	$Unselect.show()
	$Selected.hide()
	$RewardSprite.hide()
	$RewardSprite.texture = url

func displayreward():
	$RewardSprite.show()