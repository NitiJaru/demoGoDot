extends Node

# Rotate control
var _rotate_round = 1
var _rotate_round_input = 1

# Animated speed control
var _minimum_speed_animated = 0.2
var _maximum_animated_speed = 1
var _animated_speed = 0.2
var _animated_speed_input = 0.2

# Reward control
var _minimumRewardSlot = 1
var _maximumRewardSlot = 8
var _reward_slot = 1

# Is play prefix rotate round completed
var _isCompletedRoateRound

# Is switch HUD to ExactlyMode
var _isExactlyMode = false

func _ready():
	# Set Reward images
	random_reward_image()
	
	$HUDContainer/SwitchModeButton.text = "Switch to Random reward"
	$HUDContainer/ExactlyContainer.hide()

func init_game():
	# Reset isCompletedRoateRound for new game
	_isCompletedRoateRound = false
	
	if(_isExactlyMode): init_game_exactly()
	else: init_game_random()
	
	# Set animate speed
	set_animated_timer(_animated_speed)

func init_game_random():
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

func init_game_exactly():
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
	else: _animated_speed_input = animtion_speed_input
	_animated_speed = _animated_speed_input
	
	# Set reward slot
	var rewardSlot = int($HUDContainer/ExactlyContainer/RewardContainer/NumberControlContainer/InputLineEdit.text)
	if(rewardSlot < _minimumRewardSlot): _reward_slot = _minimumRewardSlot
	elif(rewardSlot > _maximumRewardSlot): _reward_slot = _maximumRewardSlot
	else: _reward_slot = rewardSlot

func random_reward_image():
	for index in $GameContainer.get_child_count():
		var randomImage = randi()%3+1
		var reward_image
		if(randomImage == 1): reward_image = preload("res://img/reward_01.png")
		elif(randomImage == 2): reward_image = preload("res://img/reward_02.png")
		else: reward_image = preload("res://img/reward_03.png")
		$GameContainer.get_child(index).init(reward_image)

func set_animated_timer(number):
	for index in $GameContainer.get_child_count():
		$GameContainer.get_child(index).set_playtimer(number)

func calculate_game(number):
	var isOutOfRound = _rotate_round < 0
	if(!_isCompletedRoateRound && !isOutOfRound):play_animation(number)
	elif(!_isCompletedRoateRound):
		_isCompletedRoateRound = true
		_rotate_round = (_rotate_round_input - 2)
		is_increment_speed_management(true)
		start_round()
	elif((_isCompletedRoateRound && _reward_slot != number) || !isOutOfRound):
		is_increment_speed_management(true)
		play_animation(number)
	else:game_finish(number)

func play_animation(number):
	var isLastSlot = number == 8
	if(!isLastSlot):$GameContainer.get_child(number).play_animation()
	else :
		start_round()
		_rotate_round -= 1
	
# Start play animation circle round
func start_round():
	$GameContainer/Reward_1.play_animation()

# Switch HUD between Random and Exactly mode
func switch_HUD_mode():
	_isExactlyMode = !_isExactlyMode
	if(_isExactlyMode):
		$HUDContainer/StartButton.margin_top = -65
		$HUDContainer/SwitchModeButton.text = "Switch to Random reward"
		$HUDContainer/ExactlyContainer.show()
	else:
		$HUDContainer/StartButton.margin_top = -200
		$HUDContainer/SwitchModeButton.text = "Switch to Exactly reward"
		$HUDContainer/ExactlyContainer.hide()

# Start game
func start_game():
	init_game()
	start_round()
	clear_reward_display()
	$HUDContainer.hide()

func game_finish(number):
	$GameContainer.get_child(number-1).display_reward()
	$HUDContainer.show()

# Clear reward display
func clear_reward_display():
	for index in $GameContainer.get_child_count():
		$GameContainer.get_child(index).clear_display_reward()
	
# Control Rotate number
func is_increment_rotate_round_management(isIncrement):
	_rotate_round_input = int($HUDContainer/ExactlyContainer/RoateContainer/NumberControlContainer/InputLineEdit.text)
	if(isIncrement): _rotate_round_input += 1
	else:
		var minimum_rotate_round_input = 1
		if(_rotate_round_input > minimum_rotate_round_input):_rotate_round_input -= 1
	$HUDContainer/ExactlyContainer/RoateContainer/NumberControlContainer/InputLineEdit.text = str(_rotate_round_input)

# Control Rotate speed number
func is_increment_speed_management_and_update_gui(isIncrement):
	is_increment_speed_management(isIncrement)
	$HUDContainer/ExactlyContainer/RoateSpeedContainer/NumberControlContainer/InputLineEdit.text = str(_animated_speed)

func is_increment_speed_management(isIncrement):
	_animated_speed = float($HUDContainer/ExactlyContainer/RoateSpeedContainer/NumberControlContainer/InputLineEdit.text)
	if(isIncrement):
		_animated_speed += _minimum_speed_animated
		if(_animated_speed > _maximum_animated_speed):_animated_speed = _maximum_animated_speed
	else:
		var minimum_animated_speed_can_decrement = 0.4
		if(_animated_speed > minimum_animated_speed_can_decrement):_animated_speed -= _minimum_speed_animated

# Control Reward slot number
func is_increment_reward_slot_management(isIncrement):
	_reward_slot = int($HUDContainer/ExactlyContainer/RewardContainer/NumberControlContainer/InputLineEdit.text)
	if(isIncrement): 
		if(_reward_slot < _maximumRewardSlot): _reward_slot += 1
	else: 
		if(_reward_slot > _minimumRewardSlot): _reward_slot -= 1
	$HUDContainer/ExactlyContainer/RewardContainer/NumberControlContainer/InputLineEdit.text = str(_reward_slot)

# Function from buttons
# Detech on Rotate numbers button was been press
func _on_RotateDecrementButton_pressed():is_increment_rotate_round_management(false)
func _on_RotateIncrementButton_pressed():is_increment_rotate_round_management(true)

# Detech on Rotate speed numbers button was been press
func _on_SpeedDecrementButton_pressed():is_increment_speed_management_and_update_gui(false)
func _on_SpeedIncrementButton_pressed():is_increment_speed_management_and_update_gui(true)

# Detech on Reward slot numbers button was been press
func _on_RewardSlotDecrementButton_pressed():is_increment_reward_slot_management(false)
func _on_RewardSlotIncrementButton_pressed():is_increment_reward_slot_management(true)

# Detect each Reward circle finished animation
func _on_Reward_1_finish_play_animation():calculate_game(1)
func _on_Reward_2_finish_play_animation():calculate_game(2)
func _on_Reward_3_finish_play_animation():calculate_game(3)
func _on_Reward_4_finish_play_animation():calculate_game(4)
func _on_Reward_5_finish_play_animation():calculate_game(5)
func _on_Reward_6_finish_play_animation():calculate_game(6)
func _on_Reward_7_finish_play_animation():calculate_game(7)
func _on_Reward_8_finish_play_animation():calculate_game(8)

# Call switch_HUD_mode function when this function work
func _on_SwitchModeButton_pressed():switch_HUD_mode()

# Call start_game function when this function work
func _on_StartButton_pressed():start_game()

# Continue play background sound
func _on_BackgroundSound_finished(): $BackgroundSound.play()
