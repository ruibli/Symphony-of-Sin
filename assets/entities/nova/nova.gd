extends CharacterBody2D

signal hit

@export var awareness = 100
@export var speed = 200
@export var damage = 1
@export var attack = 1
@export var gold = 0
@export var cooldown = .25
@export var bullet_scene : PackedScene
var can_shoot = true

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
		$NovaBodyAnim.play()
		$NovaArmAnim.play()
	else:
		$NovaBodyAnim.stop()
		$NovaArmAnim.stop()
	
	move_and_slide()
	$NovaBodyAnim.global_position = $NovaCollision.global_position
	$NovaArmAnim.global_position = $NovaCollision.global_position

	# Animations
	if Input.is_action_pressed("attack"): # attack while walking
		if velocity.x < 0:
			$NovaBodyAnim.animation = "walk_left"
			$NovaBodyAnim.flip_h = false
			$NovaArmAnim.animation = "walk_left"
		elif velocity.x > 0:
			$NovaBodyAnim.animation = "walk_left" # right
			$NovaBodyAnim.flip_h = true
			$NovaArmAnim.animation = "walk_left"
		elif velocity.y < 0:
			$NovaBodyAnim.animation = "walk_up"
			$NovaBodyAnim.flip_h = false
			$NovaArmAnim.animation = "walk_up"
		elif velocity.y > 0:
			$NovaBodyAnim.animation = "walk_down"
			$NovaBodyAnim.flip_h = false
			$NovaArmAnim.animation = "crossbow_down"
	else: # only walking
		if velocity.x < 0:
			$NovaBodyAnim.animation = "walk_left"
			$NovaBodyAnim.flip_h = false
			$NovaArmAnim.animation = "walk_left"
			$NovaArmAnim.flip_h = false
		elif velocity.x > 0:
			$NovaBodyAnim.animation = "walk_left" # right
			$NovaBodyAnim.flip_h = true
			$NovaArmAnim.animation = "walk_left"
			$NovaArmAnim.flip_h = true
		elif velocity.y < 0:
			$NovaBodyAnim.animation = "walk_up"
			$NovaBodyAnim.flip_h = false
			$NovaArmAnim.animation = "walk_up"
			$NovaArmAnim.flip_h = false
		elif velocity.y > 0:
			$NovaBodyAnim.animation = "walk_down"
			$NovaBodyAnim.flip_h = false
			$NovaArmAnim.animation = "walk_down"
			$NovaArmAnim.flip_h = false
	#attacking
	if Input.is_action_just_pressed("attack"):
		shoot()

func shoot():
	if not can_shoot:
		return
	can_shoot = false
	$BowCooldown.start()
	var b = bullet_scene.instantiate()
	get_tree().root.add_child(b)
	b.start(position + Vector2(0, -8))

func _on_bow_cooldown_timeout():
	can_shoot = true
