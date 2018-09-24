extends RigidBody2D

export (int) var min_speed = 150 # Minimum speed range.
export (int) var max_speed = 250 # Maximum speed range.
var mob_types = ["walk", "swim", "fly"]

func _ready():
    $AnimatedSprite.animation = mob_types[randi() % mob_types.size()]
    pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Visibility_screen_exited():
    queue_free()
    pass # replace with function body
