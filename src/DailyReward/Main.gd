extends Node

var rotate_round
var rotate_round_input
var reward_slot_circle
var animated_speed
var isCompletedRoateRound

func initigame():
	
	# Reset isCompletedRoateRound for new game
	isCompletedRoateRound = false
	
	# Set Reward images
	setrewardimage()
	
	# Set rotate times
	var minimumRoateTimes = 1
	var roateTimes = int($HUDContainer/RoateContainer/RoateLineEdit.text)
	if(roateTimes < minimumRoateTimes): rotate_round_input = minimumRoateTimes
	else: rotate_round_input = roateTimes
	
	# Set rotate prefix
	var prefixRotateTimes = 2
	rotate_round = prefixRotateTimes	
	
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
	var isOutOfRound = rotate_round < 0
	if(!isCompletedRoateRound && !isOutOfRound):
		playanimation(number)
	elif(!isCompletedRoateRound):
		isCompletedRoateRound = true
		rotate_round = (rotate_round_input - 2)
		animated_speed += 0.25
		setanimated(animated_speed)
		$RewardCircle_1._playanimation()
	elif((isCompletedRoateRound && reward_slot_circle != number) || !isOutOfRound):
		animated_speed += 0.075
		setanimated(animated_speed)
		playanimation(number)
	else:
		displayreward(number)
		$HUDContainer.show()

func setrewardimage():
	$RewardCircle_1.init(preload("res://img/reward_01.png"))
	$RewardCircle_2.init(preload("res://img/reward_02.png"))
	$RewardCircle_3.init(preload("res://img/reward_03.png"))
	$RewardCircle_4.init(preload("res://img/reward_01.png"))
	$RewardCircle_5.init(preload("res://img/reward_03.png"))
	$RewardCircle_6.init(preload("res://img/reward_01.png"))

func setanimated(number):
	$RewardCircle_1/PlayTimer.wait_time = number
	$RewardCircle_2/PlayTimer.wait_time = number
	$RewardCircle_3/PlayTimer.wait_time = number
	$RewardCircle_4/PlayTimer.wait_time = number
	$RewardCircle_5/PlayTimer.wait_time = number
	$RewardCircle_6/PlayTimer.wait_time = number

func playanimation(number):
	if(number == 1):$RewardCircle_2._playanimation()
	elif(number == 2):$RewardCircle_3._playanimation()
	elif(number == 3):$RewardCircle_4._playanimation()
	elif(number == 4):$RewardCircle_5._playanimation()
	elif(number == 5):$RewardCircle_6._playanimation()
	elif(number == 6):
		$RewardCircle_1._playanimation()
		rotate_round -= 1

func displayreward(number):
	if(number == 1):$RewardCircle_1.displayreward()
	elif(number == 2):$RewardCircle_2.displayreward()
	elif(number == 3):$RewardCircle_3.displayreward()
	elif(number == 4):$RewardCircle_4.displayreward()
	elif(number == 5):$RewardCircle_5.displayreward()
	elif(number == 6):$RewardCircle_6.displayreward()