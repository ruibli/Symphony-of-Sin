extends CharacterBody2D

signal hit

@onready var camera_pos = Vector2(0,0)
@export var arrow_scene : PackedScene
var awareness = 100
var awareness_max = 100
var speed = 150
var power = 1
var attack = 1
var gold = 0

var cooldown = 1
var can_shoot = true
var direction = "down"
var current_weapon = "hand_crossbow"
var foot = true
var can_hit = true

func _ready():
	$BowCooldown.wait_time = cooldown

func set_nova():
	awareness = Glova.g_stats("get",0)[0]
	awareness_max = Glova.g_stats("get",0)[1]
	speed = Glova.g_stats("get",0)[2]
	power = Glova.g_stats("get",0)[3]
	attack = Glova.g_stats("get",0)[4]
	gold = Glova.g_stats("get",0)[5]
	
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
		queue_free()
	if awareness > awareness_max:
		awareness = awareness_max
	set_nova()
	
	for i in range(get_slide_collision_count()): # collision
			var collision = get_slide_collision(i)
			if "damage" in collision.get_collider():
				if collision.get_collider().source == "enemy" and can_hit == true:
					awareness -= collision.get_collider().damage
					can_hit = false
					$HitCooldown.start()
	
# Crossbow Animations
	if current_weapon == "hand_crossbow":
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
	if area.get_name() == 'CameraArea':
		var collision_shape = area.get_node("CollisionShape2D")
		camera_pos = collision_shape.global_position

func _on_hit_cooldown_timeout():
	can_hit = true
