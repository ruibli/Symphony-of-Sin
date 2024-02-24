extends CharacterBody2D

signal hit

@export var awareness = 100
@export var speed = 200
@export var damage = 1
@export var attack = 1
@export var gold = 0

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

	if velocity.length() >= 0:
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
