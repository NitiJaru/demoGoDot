extends Node

var roate_round
var reward_slot_circle
var animated_speed
var isCompletedRoateRound
var speed_increament

func _ready():
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func initigame():
	
	# Reset isCompletedRoateRound for new game
	isCompletedRoateRound = false
	
	# Set roate times
	var minimumRoateTimes = 2
	var roateTimes = int($HUDContainer/RoateContainer/RoateLineEdit.text)
	if(roateTimes < minimumRoateTimes): roate_round = minimumRoateTimes
	else: roate_round = roateTimes	
	
	# Set reward slot
	var minimumRewardSlot = 1
	var maximumRewardSlot = 6
	var rewardSlot = int($HUDContainer/RewardContainer/RewardLineEdit.text)
	if(rewardSlot < minimumRewardSlot): reward_slot_circle = minimumRewardSlot
	elif(rewardSlot > maximumRewardSlot): reward_slot_circle = maximumRewardSlot
	else: reward_slot_circle = rewardSlot
	
	# Set animate speed
	animated_speed = float($HUDContainer/RoateSpeedContainer/RoateSpeedLineEdit.text)
	setanimated(animated_speed)

func _on_StartButton_pressed():
	initigame()
	$RewardCircle_1._playanimation()
	$HUDContainer.hide()
	pass # replace with function body

func _on_RewardCircle_1_finishplay():calculateanimation(1)
func _on_RewardCircle_2_finishplay():calculateanimation(2)
func _on_RewardCircle_3_finishplay():calculateanimation(3)
func _on_RewardCircle_4_finishplay():calculateanimation(4)
func _on_RewardCircle_5_finishplay():calculateanimation(5)
func _on_RewardCircle_6_finishplay():calculateanimation(6)

func calculateanimation(number):
	var isOutOfRound = roate_round < 0
	if(!isCompletedRoateRound && !isOutOfRound):
		
		if(isCompletedRoateRound):
			animated_speed += 0.05
			setanimated(animated_speed)
		
		if(number == 1):$RewardCircle_2._playanimation()
		elif(number == 2):$RewardCircle_3._playanimation()
		elif(number == 3):$RewardCircle_4._playanimation()
		elif(number == 4):$RewardCircle_5._playanimation()
		elif(number == 5):$RewardCircle_6._playanimation()
		elif(number == 6):
			$RewardCircle_1._playanimation()
			roate_round -= 1
	elif(!isCompletedRoateRound):
		isCompletedRoateRound = true
		roate_round = 2
		speed_increament = animated_speed/2
		animated_speed += speed_increament
		setanimated(animated_speed)
		$RewardCircle_1._playanimation()
	elif((isCompletedRoateRound && reward_slot_circle != number) || !isOutOfRound):
		animated_speed += 0.05
		setanimated(animated_speed)
		if(number == 1):$RewardCircle_2._playanimation()
		elif(number == 2):$RewardCircle_3._playanimation()
		elif(number == 3):$RewardCircle_4._playanimation()
		elif(number == 4):$RewardCircle_5._playanimation()
		elif(number == 5):$RewardCircle_6._playanimation()
		elif(number == 6):
			$RewardCircle_1._playanimation()
			roate_round -= 1
	else:
		$HUDContainer.show()

func setanimated(number):
	$RewardCircle_1/PlayTimer.wait_time = number
	$RewardCircle_2/PlayTimer.wait_time = number
	$RewardCircle_3/PlayTimer.wait_time = number
	$RewardCircle_4/PlayTimer.wait_time = number
	$RewardCircle_5/PlayTimer.wait_time = number
	$RewardCircle_6/PlayTimer.wait_time = number