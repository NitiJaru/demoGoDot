extends Control

signal finish_play_animation

func _ready():
	$Unselect.show()
	$Selected.hide()
	$RewardSprite.hide()

func play_animation():
	$Unselect.hide()
	$Selected.show()
	$AudioStreamPlayer2D.play()
	$AnimationTimer.start()

func _on_AnimationTimer_timeout():
	$Unselect.show()
	$Selected.hide()
	emit_signal("finish_play_animation")

func init(url):
	$Unselect.show()
	$Selected.hide()
	$RewardSprite.hide()
	$RewardSprite.texture = url

func set_playtimer(number):$AnimationTimer.wait_time = number
func display_reward():$RewardSprite.show()
func clear_display_reward():$RewardSprite.hide()