extends CharacterBody2D

signal hit

@export var awareness = 100
@export var speed = 200
@export var damage = 1
@export var attack = 1
@export var gold = 0
@export var cooldown = .25
@export var arrow_scene : PackedScene
var can_shoot = true
var direction = "down"
var b

func _ready():
	start()

func start():
	$BowCooldown.wait_time = cooldown

func _process(_delta):
	velocity = Vector2.ZERO # The player's movement vector.
	# Player Movement
	if Input.is_action_pressed("move_right"):
		direction = "right"
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		direction = "left"
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		direction = "down"
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		direction = "up"
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$NovaAnimation.play()
	else:
		$NovaAnimation.stop()
	
	move_and_slide()
	$NovaAnimation.global_position = $NovaCollision.global_position
	
# Animations
	if Input.is_action_pressed("attack"): # attack while walking
		if velocity.x < 0:
			$NovaAnimation.animation = "crossbow_left"
			$NovaAnimation.flip_h = false
		elif velocity.x > 0: 
			$NovaAnimation.animation = "crossbow_right"
			$NovaAnimation.flip_h = false
		elif velocity.y < 0:
			$NovaAnimation.animation = "crossbow_up"
			$NovaAnimation.flip_h = false
		elif velocity.y > 0:
			$NovaAnimation.animation = "crossbow_down"
			$NovaAnimation.flip_h = false
	else: # only walking
		if velocity.x < 0:
			$NovaAnimation.animation = "walk_left"
			$NovaAnimation.flip_h = false
		elif velocity.x > 0: #right
			$NovaAnimation.animation = "walk_left"
			$NovaAnimation.flip_h = true
		elif velocity.y < 0:
			$NovaAnimation.animation = "walk_up"
			$NovaAnimation.flip_h = false
		elif velocity.y > 0:
			$NovaAnimation.animation = "walk_down"
			$NovaAnimation.flip_h = false
	#attacking
	if Input.is_action_pressed("attack"):
		shoot()

func shoot(): # attacking
	if can_shoot:
		can_shoot = false
		$BowCooldown.start()
		b = arrow_scene.instantiate()
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
	var size = collision_shape.shape.extents
	
	var view_size = get_viewport_rect().size
	size.y = view_size.y
	size.x = view_size.x
	
	$Camera2D.limit_top = collision_shape.global_position.y - size.y/2
	$Camera2D.limit_left = collision_shape.global_position.x - size.x/2
	
	$Camera2D.limit_bottom =$Camera2D.limit_top + size.y
	$Camera2D.limit_right = $Camera2D.limit_left + size.x
