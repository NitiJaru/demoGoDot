extends Node

# Rotate control
var _rotate_round = 1
var _rotate_round_input = 1

# Animated speed control
var _minimum_speed_animated = 0.2
var _maximum_animated_speed = 1
var _animated_speed = 0.2

# Reward control
var _minimumRewardSlot = 1
var _maximumRewardSlot = 8
var _reward_slot = 1

# Is play prefix rotate round completed
var _isCompletedRoateRound

# Is switch HUD to ExactlyMode
var _isExactlyMode = false

func _ready():
	$HUDContainer/SwitchModeButton.text = "Switch to Random reward"
	$HUDContainer/ExactlyContainer.hide()

func initigame():
	# Reset isCompletedRoateRound for new game
	_isCompletedRoateRound = false
	
	# Set Reward images
	setrewardimage()
	
	if(_isExactlyMode): initigame_advance()
	else: initigame_random()
	
	# Set animate speed
	setanimated(_animated_speed)

func initigame_random():
	# Random rotate prefix
	var randomRotateRound = randi()%3+1
	_rotate_round = randomRotateRound
	
	# Random rotate times
	var randomRotateRoundInput = randi()%2+1
	_rotate_round_input = randomRotateRoundInput
	
	# Random reward slot
	var randomRewardSlot = randi()%8+1
	_reward_slot = randomRewardSlot
	
	# Reset animate speed
	_animated_speed = 0.2

func initigame_advance():
	# Set rotate prefix
	var prefixRotateTimes = 2
	_rotate_round = prefixRotateTimes
	
	# Set rotate times
	var minimumRotateTimes = 1
	var rotateTimes = int($HUDContainer/ExactlyContainer/RoateContainer/NumberControlContainer/InputLineEdit.text)
	if(rotateTimes < minimumRotateTimes): _rotate_round_input = minimumRotateTimes
	else: _rotate_round_input = rotateTimes
	
	# Set animate speed
	var animtion_speed_input = float($HUDContainer/ExactlyContainer/RoateSpeedContainer/NumberControlContainer/InputLineEdit.text)
	if(animtion_speed_input < _minimum_speed_animated): _animated_speed = _minimum_speed_animated
	elif(animtion_speed_input > _maximum_animated_speed): _animated_speed = _maximum_animated_speed
	else: _animated_speed = animtion_speed_input
	
	# Set reward slot
	var rewardSlot = int($HUDContainer/ExactlyContainer/RewardContainer/NumberControlContainer/InputLineEdit.text)
	if(rewardSlot < _minimumRewardSlot): _reward_slot = _minimumRewardSlot
	elif(rewardSlot > _maximumRewardSlot): _reward_slot = _maximumRewardSlot
	else: _reward_slot = rewardSlot

func calculateanimation(number):
	var isOutOfRound = _rotate_round < 0
	if(!_isCompletedRoateRound && !isOutOfRound):
		playanimation(number)
	elif(!_isCompletedRoateRound):
		_isCompletedRoateRound = true
		_rotate_round = (_rotate_round_input - 2)
		_animated_speed += 0.25
		setanimated(_animated_speed)
		startround()
	elif((_isCompletedRoateRound && _reward_slot != number) || !isOutOfRound):
		if(_animated_speed < _maximum_animated_speed): _animated_speed += 0.075
		else:_animated_speed = _maximum_animated_speed
		setanimated(_animated_speed)
		playanimation(number)
	else:
		displayreward(number)
		$HUDContainer.show()

func setrewardimage():
	$GameContainer/RewardCircle_1.init(preload("res://img/reward_01.png"))
	$GameContainer/RewardCircle_2.init(preload("res://img/reward_02.png"))
	$GameContainer/RewardCircle_3.init(preload("res://img/reward_03.png"))
	$GameContainer/RewardCircle_4.init(preload("res://img/reward_01.png"))
	$GameContainer/RewardCircle_5.init(preload("res://img/reward_03.png"))
	$GameContainer/RewardCircle_6.init(preload("res://img/reward_01.png"))
	$GameContainer/RewardCircle_7.init(preload("res://img/reward_03.png"))
	$GameContainer/RewardCircle_8.init(preload("res://img/reward_02.png"))

func setanimated(number):
	$GameContainer/RewardCircle_1/PlayTimer.wait_time = number
	$GameContainer/RewardCircle_2/PlayTimer.wait_time = number
	$GameContainer/RewardCircle_3/PlayTimer.wait_time = number
	$GameContainer/RewardCircle_4/PlayTimer.wait_time = number
	$GameContainer/RewardCircle_5/PlayTimer.wait_time = number
	$GameContainer/RewardCircle_6/PlayTimer.wait_time = number
	$GameContainer/RewardCircle_7/PlayTimer.wait_time = number
	$GameContainer/RewardCircle_8/PlayTimer.wait_time = number

func playanimation(number):
	if(number == 1):$GameContainer/RewardCircle_2._playanimation()
	elif(number == 2):$GameContainer/RewardCircle_3._playanimation()
	elif(number == 3):$GameContainer/RewardCircle_4._playanimation()
	elif(number == 4):$GameContainer/RewardCircle_5._playanimation()
	elif(number == 5):$GameContainer/RewardCircle_6._playanimation()
	elif(number == 6):$GameContainer/RewardCircle_7._playanimation()
	elif(number == 7):$GameContainer/RewardCircle_8._playanimation()
	elif(number == 8):
		startround()
		_rotate_round -= 1

func displayreward(number):
	if(number == 1):$GameContainer/RewardCircle_1.displayreward()
	elif(number == 2):$GameContainer/RewardCircle_2.displayreward()
	elif(number == 3):$GameContainer/RewardCircle_3.displayreward()
	elif(number == 4):$GameContainer/RewardCircle_4.displayreward()
	elif(number == 5):$GameContainer/RewardCircle_5.displayreward()
	elif(number == 6):$GameContainer/RewardCircle_6.displayreward()
	elif(number == 7):$GameContainer/RewardCircle_7.displayreward()
	elif(number == 8):$GameContainer/RewardCircle_8.displayreward()

# Start play animation circle round
func startround():
	$GameContainer/RewardCircle_1._playanimation()

# Control Rotate number
func RotateNumberManagement(isIncrement):
	_rotate_round_input = int($HUDContainer/ExactlyContainer/RoateContainer/NumberControlContainer/InputLineEdit.text)
	if(isIncrement): _rotate_round_input += 1
	else:
		var minimum_rotate_round_input = 1
		if(_rotate_round_input > minimum_rotate_round_input):_rotate_round_input -= 1
	$HUDContainer/ExactlyContainer/RoateContainer/NumberControlContainer/InputLineEdit.text = str(_rotate_round_input)

# Control Rotate speed number
func RotateSpeedNumberManagement(isIncrement):
	_animated_speed = float($HUDContainer/ExactlyContainer/RoateSpeedContainer/NumberControlContainer/InputLineEdit.text)
	if(isIncrement):
		_animated_speed += _minimum_speed_animated
		if(_animated_speed > _maximum_animated_speed): _animated_speed = _maximum_animated_speed
	else:
		var minimum_animated_speed_can_decrement = 0.4
		if(_animated_speed > minimum_animated_speed_can_decrement): _animated_speed -= _minimum_speed_animated
	$HUDContainer/ExactlyContainer/RoateSpeedContainer/NumberControlContainer/InputLineEdit.text = str(_animated_speed)

# Control Reward slot number
func RewardNumberManagement(isIncrement):
	_reward_slot = int($HUDContainer/ExactlyContainer/RewardContainer/NumberControlContainer/InputLineEdit.text)
	if(isIncrement): 
		if(_reward_slot < _maximumRewardSlot): _reward_slot += 1
	else: 
		if(_reward_slot > _minimumRewardSlot): _reward_slot -= 1
	$HUDContainer/ExactlyContainer/RewardContainer/NumberControlContainer/InputLineEdit.text = str(_reward_slot)

# Detech on Rotate numbers button was been press
func _on_RotateDecrementButton_pressed():RotateNumberManagement(false)
func _on_RotateIncrementButton_pressed():RotateNumberManagement(true)
# Detech on Rotate speed numbers button was been press
func _on_SpeedDecrementButton_pressed():RotateSpeedNumberManagement(false)
func _on_SpeedIncrementButton_pressed():RotateSpeedNumberManagement(true)
# Detech on Reward slot numbers button was been press
func _on_RewardSlotDecrementButton_pressed():RewardNumberManagement(false)
func _on_RewardSlotIncrementButton_pressed():RewardNumberManagement(true)

# Switch HUD between Random and Exactly mode
func _on_SwitchModeButton_pressed():
	_isExactlyMode = !_isExactlyMode
	if(_isExactlyMode):
		$HUDContainer/StartButton.margin_top = -65
		$HUDContainer/SwitchModeButton.text = "Switch to Random reward"
		$HUDContainer/ExactlyContainer.show()
	else:
		$HUDContainer/StartButton.margin_top = -200
		$HUDContainer/SwitchModeButton.text = "Switch to Exactly reward"
		$HUDContainer/ExactlyContainer.hide()

# Start Game
func _on_StartButton_pressed():
	initigame()
	startround()
	$HUDContainer.hide()

# Detect each Reward circle finished animation
func _on_RewardCircle_1_finishplay():calculateanimation(1)
func _on_RewardCircle_2_finishplay():calculateanimation(2)
func _on_RewardCircle_3_finishplay():calculateanimation(3)
func _on_RewardCircle_4_finishplay():calculateanimation(4)
func _on_RewardCircle_5_finishplay():calculateanimation(5)
func _on_RewardCircle_6_finishplay():calculateanimation(6)
func _on_RewardCircle_7_finishplay():calculateanimation(7)
func _on_RewardCircle_8_finishplay():calculateanimation(8)