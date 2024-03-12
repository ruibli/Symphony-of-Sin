extends CharacterBody2D

@onready var camera_pos = Vector2(0,0)
var center = Vector2(0,0)
@export var arrow_scene : PackedScene
var health = 100
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
	health = Glova.g_stats()[0]
	health_max = Glova.g_stats()[1]
	speed = Glova.g_stats()[2]
	power = Glova.g_stats()[3]
	attack = Glova.g_stats()[4]
	gold = Glova.g_stats()[5]
	
	inv = Glova.g_inv()
	hotbar = Glova.g_hotbar()
	
func _process(_delta):
	velocity = Vector2.ZERO
	# Player Movement
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$NovaAnimation.play()
	else:
		$NovaAnimation.stop()
		foot = true
	
	move_and_slide()
	global_position = $NovaCollision.global_position
	Glova.g_pos($NovaCollision.global_position)
	$Camera2D.global_position = camera_pos
	if health <= 0:
		Glova.g_level(-1)
		queue_free()
	if health > health_max:
		health = health_max
	set_nova()
	
	if current == "crossbow": # Crossbow Animations
		# attack while walking
		if Input.is_action_pressed("attack_up"):
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
		elif Input.is_action_pressed("attack_left"):
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
		if direction == "up":
			velocity.y -= 1
			b.global_position = $NovaCollision.global_position
		elif direction == "down":
			velocity.y += 1
			b.global_position = $NovaCollision.global_position
		elif direction == "left":
			velocity.x -= 1
			b.global_position = $NovaCollision.global_position
		elif direction == "right":
			velocity.x += 1
			b.global_position = $NovaCollision.global_position
		b.start(direction)
		get_tree().root.add_child(b)

func _on_bow_cooldown_timeout(): # bow cooldown
	can_shoot = true

func _on_room_detector_area_entered(area: Area2D) -> void: #camera stuff
	if area.get_name() == 'CameraArea':
		var collision_shape = area.get_node("CollisionShape2D")
		camera_pos = collision_shape.global_position
		center = camera_pos

func _on_hit_cooldown_timeout():
	can_hit = true
	set_collision_layer_value(2,false)
	set_collision_layer_value(2,true)

func hit(ow):
	if can_hit:
		can_hit = false
		$HitCooldown.start()
		Glova.g_stats([-ow, 0, 0, 0, 0, 0])

func boop(type):
	if type == 1:
		if velocity.y < 0: #up
			global_position = center + Vector2(0,-184)
		elif velocity.y > 0: #down
			global_position = center + Vector2(0,184)
	elif type == 2:
		if velocity.x < 0: #left
			global_position = center + Vector2(-184,0)
		elif velocity.x > 0: #right
			global_position = center + Vector2(184,0)
