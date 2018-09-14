extends Area2D
signal hit

export (int) var speed  # How fast the player will move (pixels/sec).
var screensize  # Size of the game window.

func _ready():
	screensize = get_viewport_rect().size
	pass

func _process(delta):

#	Scale charactor movement
	var velocity = Vector2() # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
        velocity.x += 1
	if Input.is_action_pressed("ui_left"):
        velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
        velocity.y += 1
	if Input.is_action_pressed("ui_up"):
        velocity.y -= 1
	if velocity.length() > 0:
        velocity = velocity.normalized() * speed
        $AnimatedSprite.play()
	else:
        $AnimatedSprite.stop()

#	play charactor movement 
	position += velocity * delta
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)

#	play charactor movement animation
	if velocity.x != 0:
        $AnimatedSprite.animation = "right"
        $AnimatedSprite.flip_v = false
        $AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
        $AnimatedSprite.animation = "up"
        $AnimatedSprite.flip_v = velocity.y > 0
	pass

func _on_Player_body_entered(body):
	hide() # Player disappears after being hit.
	emit_signal("hit")
	$CollisionShape2D.disabled = true
	pass # replace with function body

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false