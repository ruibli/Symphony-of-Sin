extends Area2D

<<<<<<< Updated upstream
@export var speed = 200 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.
=======
var awareness = 100
var weapon = "none"
var damage = 1
var attack = 200
var speed = 200
var gold = 0
# not adding inventory rn, dunno how were handling that
>>>>>>> Stashed changes

func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	global_position -= velocity * delta

	if velocity.x < 0:
		$AnimatedSprite2D.animation = "walk_left"
	elif velocity.x > 0:
		$AnimatedSprite2D.animation = "walk_right"
	elif velocity.y < 0:
		$AnimatedSprite2D.animation = "walk_up"
	elif velocity.y > 0:
		$AnimatedSprite2D.animation = "walk_down"
		
	print(position)
