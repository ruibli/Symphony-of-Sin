extends CharacterBody2D

signal hit

@export var awareness = 100
@export var speed = 200
@export var power = 1
@export var attack = 1
@export var gold = 0
var cooldown = 1
@export var arrow_scene : PackedScene
var can_shoot = true
var direction = "down"
var current_weapon = "hand_crossbow"
var foot = true
var camera_pos


func _ready():
	start()

func start():
	$BowCooldown.wait_time = cooldown

func _process(_delta):
	velocity = Vector2.ZERO # The player's movement vector.
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
		$NovaAnimation.play()
	else:
		$NovaAnimation.stop()
		foot = true
	
	move_and_slide()
	$NovaAnimation.global_position = $NovaCollision.global_position
	Glova.set_pos($NovaCollision.global_position)
	$Camera2D.global_position = camera_pos
	if awareness <= 0:
		Glova.set_level(0)
	if awareness > 100:
		awareness = 100
	
	# collision code here
	
# Crossbow Animations
	if current_weapon == "hand_crossbow" :
		# attack while walking
		if Input.is_action_pressed("attack_left"):
			$NovaAnimation.play("crossbow_left")
			$NovaAnimation.flip_h = false
			direction = "left"
			if foot:
				$NovaAnimation.frame = 1
				foot = false
			shoot()
		elif Input.is_action_pressed("attack_right"):
			$NovaAnimation.play("crossbow_right")
			$NovaAnimation.flip_h = false
			direction = "right"
			if foot:
				$NovaAnimation.frame = 1
				foot = false
			shoot()
		elif Input.is_action_pressed("attack_up"):
			$NovaAnimation.play("crossbow_up")
			$NovaAnimation.flip_h = false
			direction = "up"
			if foot:
				$NovaAnimation.frame = 1
				foot = false
			shoot()
		elif Input.is_action_pressed("attack_down"):
			$NovaAnimation.play("crossbow_down")
			$NovaAnimation.flip_h = false
			direction = "down"
			if foot:
				$NovaAnimation.frame = 1
				foot = false
			shoot()
		# if not shooting in a dirction, walk facing direction player is moving
		elif Input.is_action_pressed("move_up"): 
			$NovaAnimation.play("crossbow_up")
			$NovaAnimation.flip_h = false
			direction = "up"
			if foot:
				$NovaAnimation.frame = 1
				foot = false
		elif Input.is_action_pressed("move_down"):
			$NovaAnimation.play("crossbow_down")
			$NovaAnimation.flip_h = false
			direction = "down"
			if foot:
				$NovaAnimation.frame = 1
				foot = false
		elif Input.is_action_pressed("move_left"):
			$NovaAnimation.play("crossbow_left")
			$NovaAnimation.flip_h = false
			direction = "left"
			if foot:
				$NovaAnimation.frame = 1
				foot = false
		elif Input.is_action_pressed("move_right"):
			$NovaAnimation.play("crossbow_right")
			$NovaAnimation.flip_h = false
			direction = "right"
			if foot:
				$NovaAnimation.frame = 1
				foot = false

func shoot(): # attacking
	if can_shoot:
		can_shoot = false
		$BowCooldown.start()
		var b = arrow_scene.instantiate()
		if direction == "right":
			velocity.x += 1
			b.global_position = $NovaCollision.global_position + Vector2(15, 0)
		elif direction == "left":
			velocity.x -= 1
			b.global_position = $NovaCollision.global_position + Vector2(-15, 0)
		elif direction == "down":
			velocity.y += 1
			b.global_position = $NovaCollision.global_position + Vector2(0, 20)
		elif direction == "up":
			velocity.y -= 1
			b.global_position = $NovaCollision.global_position + Vector2(0, -20)
		b.start(direction)
		get_tree().root.add_child(b)

func _on_bow_cooldown_timeout(): # bow cooldown
	can_shoot = true

func _on_room_detector_area_entered(area: Area2D) -> void: #camera stuff
	var collision_shape = area.get_node("CollisionShape2D")
	camera_pos = collision_shape.global_position
