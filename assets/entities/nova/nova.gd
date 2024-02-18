extends Area2D

signal hit

@export var awareness = 100
@export var speed = 200
@export var damage = 1
@export var attack = 1
@export var gold = 0

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
		$AnimatedSprite2D.flip_h = false
	elif velocity.x > 0:
		$AnimatedSprite2D.animation = "walk_left" # right
		$AnimatedSprite2D.flip_h = true
	elif velocity.y < 0:
		$AnimatedSprite2D.animation = "walk_up"
	elif velocity.y > 0:
		$AnimatedSprite2D.animation = "walk_down"
		
	print("Nova:" + str(position))
	# print("Camera:" + str(Camera2D.position))
