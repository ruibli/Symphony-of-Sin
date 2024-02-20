extends Area2D

signal hit

@export var awareness = 100
@export var speed = 200
@export var damage = 1
@export var attack = 1
@export var gold = 0
	
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	# Player Movement
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
		$BodyAnim.play()
		$ArmAnim.play()

	else:
		$BodyAnim.stop()
		$ArmAnim.stop()
	
	$BodyAnim.position += velocity * delta
	$ArmAnim.position += velocity * delta

	# Animations
	if velocity.x < 0:
		$BodyAnim.animation = "walk_left"
		$BodyAnim.flip_h = false
		$ArmAnim.animation = "walk_left"
		$ArmAnim.flip_h = false
	elif velocity.x > 0:
		$BodyAnim.animation = "walk_left" # right
		$BodyAnim.flip_h = true
		$ArmAnim.animation = "walk_left"
		$ArmAnim.flip_h = true
	elif velocity.y < 0:
		$BodyAnim.animation = "walk_up"
		$BodyAnim.flip_h = false
		$ArmAnim.animation = "walk_up"
		$ArmAnim.flip_h = false
	elif velocity.y > 0:
		$BodyAnim.animation = "walk_down"
		$BodyAnim.flip_h = false
		$ArmAnim.animation = "walk_down"
		$ArmAnim.flip_h = false

# Outline for attack anims
	#if Input.is_action_pressed("attack"):
		#if currently on crossbow:
			#if Input.is_action_pressed("move_right"):
				#$AnimatedSprite2D.animation = "crossbow_left" # right
				#$AnimatedSprite2D.flip_h = true
			#if Input.is_action_pressed("move_left"):
				#$AnimatedSprite2D.animation = "crossbow_left"
				#$AnimatedSprite2D.flip_h = false
			#if Input.is_action_pressed("move_down"):
				#$AnimatedSprite2D.animation = "crossbow_down"
			#if Input.is_action_pressed("move_up"):
				#$AnimatedSprite2D.animation = "crossbow_up"
