extends CharacterBody2D

signal hit

@onready var camera_pos = Vector2(0,0)
@export var arrow_scene : PackedScene
var heatlh= 100
var health_max = 100
var speed = 150
var power = 1
var attack = 1
var gold = 0

var inv = []
var hotbar = ["Crossbow", " ", " ", " ", " ", " ", " ", " "]

var cooldown = 1
var can_shoot = true
var direction = "down"
var current = "crossbow"
var foot = true
var can_hit = true

func _ready():
	$BowCooldown.wait_time = cooldown

func set_nova():
	heatlh = Glova.g_stats()[0]
	health_max = Glova.g_stats()[1]
	speed = Glova.g_stats()[2]
	power = Glova.g_stats()[3]
	attack = Glova.g_stats()[4]
	gold = Glova.g_stats()[5]
	
	inv = Glova.g_inv()
	hotbar = Glova.g_hotbar()
	
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
	Glova.g_pos($NovaCollision.global_position)
	$Camera2D.global_position = camera_pos
	if heatlh <= 0:
		Glova.set_level(-1)
		queue_free()
	if heatlh > health_max:
		heatlh = health_max
	set_nova()
	
	for i in range(get_slide_collision_count()): # collision
			var collision = get_slide_collision(i)
			if "damage" in collision.get_collider():
				if collision.get_collider().source == "enemy" and can_hit == true:
					heatlh -= collision.get_collider().damage
					can_hit = false
					$HitCooldown.start()
	
# Crossbow Animations
	if current == "crossbow":
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
