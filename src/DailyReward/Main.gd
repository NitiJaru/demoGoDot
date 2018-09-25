extends Node

var rotate_round
var rotate_round_input
var reward_slot
var animated_speed
var isCompletedRoateRound

func initigame(isAdvance):
	# Reset isCompletedRoateRound for new game
	isCompletedRoateRound = false
	
	# Set Reward images
	setrewardimage()
	
	if(isAdvance): initigame_advance()
	else: initigame_basic()

func initigame_basic():
	# Random rotate prefix
	var randomRotateRound = randi()%3+1
	rotate_round = randomRotateRound
	
	# Random rotate times
	var randomRotateRoundInput = randi()%2+1
	rotate_round_input = randomRotateRoundInput
	
	# Random reward slot
	var randomRewardSlot = randi()%6+1
	reward_slot = randomRewardSlot
	
	# Set animate speed
	animated_speed = 0.15
	setanimated(animated_speed)

func initigame_advance():
	# Set rotate prefix
	var prefixRotateTimes = 2
	rotate_round = prefixRotateTimes	
	
	# Set rotate times
	var minimumRotateTimes = 1
	var rotateTimes = int($HUDContainer/AdvanceContainer/RoateContainer/RoateLineEdit.text)
	if(rotateTimes < minimumRotateTimes): rotate_round_input = minimumRotateTimes
	else: rotate_round_input = rotateTimes
	
	# Set reward slot
	var minimumRewardSlot = 1
	var maximumRewardSlot = 6
	var rewardSlot = int($HUDContainer/AdvanceContainer/RewardContainer/RewardLineEdit.text)
	if(rewardSlot < minimumRewardSlot): reward_slot = minimumRewardSlot
	elif(rewardSlot > maximumRewardSlot): reward_slot = maximumRewardSlot
	else: reward_slot = rewardSlot
	
	# Set animate speed
	animated_speed = float($HUDContainer/AdvanceContainer/RoateSpeedContainer/RoateSpeedLineEdit.text)
	setanimated(animated_speed)


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
	elif((isCompletedRoateRound && reward_slot != number) || !isOutOfRound):
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

func _on_RandomButton_pressed():
	$HUDContainer/BasicContainer.show()
	$HUDContainer/AdvanceContainer.hide()

func _on_ExactlyButton_pressed():
	$HUDContainer/BasicContainer.hide()
	$HUDContainer/AdvanceContainer.show()

func _on_BasicStartButton_pressed():
	initigame(false)
	$RewardCircle_1._playanimation()
	$HUDContainer.hide()

func _on_AdvanceStartButton_pressed():
	initigame(true)
	$RewardCircle_1._playanimation()
	$HUDContainer.hide()
