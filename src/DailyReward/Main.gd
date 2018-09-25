extends Node

var roate_round
var reward_circle
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _on_StartButton_pressed():
	roate_round = int($RoateContainer/RoateLineEdit.text)
	reward_circle = int($RewardContainer/RewardLineEdit.text)
	$RewardCircle_1._playanimation()
	pass # replace with function body

func _on_RewardCircle_1_finishplay():
	if(reward_circle != 1 || roate_round != 0):
		$RewardCircle_2._playanimation()
	pass # replace with function body


func _on_RewardCircle_2_finishplay():
	if(reward_circle != 2 || roate_round != 0):
		$RewardCircle_3._playanimation()
	pass # replace with function body

func _on_RewardCircle_3_finishplay():
	if(reward_circle != 3 || roate_round != 0):
		$RewardCircle_4._playanimation()
	pass # replace with function body

func _on_RewardCircle_4_finishplay():
	if(reward_circle != 4 || roate_round != 0):
		$RewardCircle_5._playanimation()
	pass # replace with function body

func _on_RewardCircle_5_finishplay():
	if(reward_circle != 5 || roate_round != 0):
		$RewardCircle_6._playanimation()
	pass # replace with function body

func _on_RewardCircle_6_finishplay():
	if(reward_circle != 6 || roate_round != 0):
		$RewardCircle_1._playanimation()
		roate_round -= 1
	pass # replace with function body