extends Node

var roate_round
var reward_circle

func _ready():
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
func initigame():
	roate_round = int($HUDContainer/RoateContainer/RoateLineEdit.text)
	reward_circle = int($HUDContainer/RewardContainer/RewardLineEdit.text)
	$RewardCircle_1/PlayTimer.wait_time = float($HUDContainer/RoateSpeedContainer/RoateSpeedLineEdit.text)
	$RewardCircle_2/PlayTimer.wait_time = float($HUDContainer/RoateSpeedContainer/RoateSpeedLineEdit.text)
	$RewardCircle_3/PlayTimer.wait_time = float($HUDContainer/RoateSpeedContainer/RoateSpeedLineEdit.text)
	$RewardCircle_4/PlayTimer.wait_time = float($HUDContainer/RoateSpeedContainer/RoateSpeedLineEdit.text)
	$RewardCircle_5/PlayTimer.wait_time = float($HUDContainer/RoateSpeedContainer/RoateSpeedLineEdit.text)
	$RewardCircle_6/PlayTimer.wait_time = float($HUDContainer/RoateSpeedContainer/RoateSpeedLineEdit.text)

func _on_StartButton_pressed():
	initigame()
	$RewardCircle_1._playanimation()
	$HUDContainer.hide()
	pass # replace with function body

func _on_RewardCircle_1_finishplay():calculategame(1)
func _on_RewardCircle_2_finishplay():calculategame(2)
func _on_RewardCircle_3_finishplay():calculategame(3)
func _on_RewardCircle_4_finishplay():calculategame(4)
func _on_RewardCircle_5_finishplay():calculategame(5)
func _on_RewardCircle_6_finishplay():calculategame(6)

func calculategame(number):
	var isOutOfRound = roate_round > 0
	if(reward_circle != number || isOutOfRound):
		
		if(number == 1):$RewardCircle_2._playanimation()
		elif(number == 2):$RewardCircle_3._playanimation()
		elif(number == 3):$RewardCircle_4._playanimation()
		elif(number == 4):$RewardCircle_5._playanimation()
		elif(number == 5):$RewardCircle_6._playanimation()
		elif(number == 6):
			$RewardCircle_1._playanimation()
			roate_round -= 1
	else:$HUDContainer.show()