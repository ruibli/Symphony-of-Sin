extends CharacterBody2D

@onready var camera_pos = Vector2(0,0)
var cam = false

@export var arrow_scene : PackedScene

var health = 100
var health_max = 100
var speed = 1
var power = 1
var attack = 1
var gold = 0

var inv = []
var hotbar = ["crossbow", " ", " ", " ", " ", " ", " ", " "]
var current = "crossbow"

var can_shoot = true
var direction = "down"
var type = "move"
var foot = true

var can_hit = true

func set_nova():
	health = Glova.g_stats()[0]
	health_max = Glova.g_stats()[1]
	speed = Glova.g_stats()[2]
	power = Glova.g_stats()[3]
	attack = Glova.g_stats()[4]
	gold = Glova.g_stats()[5]
	
	inv = Glova.g_inv()
	hotbar = Glova.g_hotbar()
	current = Glova.g_current()
	
	if health > health_max:
		Glova.g_stats([health_max-health, 0, 0, 0, 0, 0])
	
	Glova.g_pos(global_position)
	$Camera2D.global_position = camera_pos
	$Camera2D.position_smoothing_enabled = cam
	
	$BowCooldown.wait_time = 1.0 / attack
	
func _process(_delta):
	velocity = Vector2.ZERO
	type = "move"
	
	# Player Controls
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("attack_up"):
		type = "attack"
		direction = "up"
	if Input.is_action_pressed("attack_down"):
		type = "attack"
		direction = "down"
	if Input.is_action_pressed("attack_left"):
		type = "attack"
		direction = "left"
	if Input.is_action_pressed("attack_right"):
		type = "attack"
		direction = "right"
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * 100 * speed
		$NovaCollision/NovaAnimation.play()
	else:
		$NovaCollision/NovaAnimation.frame = 0
		$NovaCollision/NovaAnimation.stop()
		foot = true
	
	move_and_slide()
	set_nova()
	
	if type == "move":
		if velocity.y < 0 and abs(velocity.y) > abs(velocity.x): #up
			direction = "up"
		elif velocity.y > 0 and abs(velocity.y) > abs(velocity.x): #down
			direction = "down"
		elif velocity.x < 0 and abs(velocity.x) > abs(velocity.y): #left
			direction = "left"
		elif velocity.x > 0 and abs(velocity.x) > abs(velocity.y): #right
			direction = "right"
	
	if current == "crossbow": # Crossbow Animations
		if direction == "up":
			$NovaCollision/NovaAnimation.play("crossbow_up")
		elif direction == "down":
			$NovaCollision/NovaAnimation.play("crossbow_down")
		elif direction == "left":
			$NovaCollision/NovaAnimation.play("crossbow_left")
		elif direction == "right":
			$NovaCollision/NovaAnimation.play("crossbow_right")
		if velocity.length() > 0 and foot:
			$NovaCollision/NovaAnimation.frame = 1
			foot = false
		if type == "attack":
			crossbow()

func crossbow(): # attacking
	if can_shoot:
		can_shoot = false
		$BowCooldown.start()
		var b = arrow_scene.instantiate()
		b.damage = b.damage * attack
		b.global_position = global_position
		if direction == "up":
			b.velocity.y -= 1
			b.rotation_degrees = 180
		elif direction == "down":
			b.velocity.y += 1
			b.rotation_degrees = 0
		elif direction == "left":
			b.velocity.x -= 1
			b.rotation_degrees = 90
		elif direction == "right":
			b.velocity.x += 1
			b.rotation_degrees = 270
		get_tree().root.add_child(b)

func _on_bow_cooldown_timeout(): # bow cooldown
	can_shoot = true

func _on_room_detector_area_entered(area: Area2D) -> void: #camera stuff
	if area.get_name() == 'CameraArea':
		var collision_shape = area.get_node("CollisionShape2D")
		camera_pos = collision_shape.global_position

func _on_hit_cooldown_timeout():
	can_hit = true
	$novahurt.set_collision_layer_value(2,true)

func hit(ow):
	if can_hit:
		can_hit = false
		$novahurt.set_collision_layer_value(2,false)
		$HitCooldown.start()
		Glova.g_stats([-ow, 0, 0, 0, 0, 0])
		
		var tween = get_tree().create_tween()
		tween.tween_property($NovaCollision/NovaAnimation, "modulate", Color(1, 0, 0, 1), 0.05)
		if Glova.g_stats()[0] <= 0:
			await get_tree().create_timer(0.05).timeout
			Glova.g_level(-1)
		else:
			tween.tween_property($NovaCollision/NovaAnimation, "modulate", Color(1, 1, 1, 1), 0.05)

func boop(dir):
	if dir == "up":
		global_position = camera_pos + Vector2(0,-224)
	elif dir == "down":
		global_position = camera_pos + Vector2(0,224)
	elif dir == "left":
		global_position = camera_pos + Vector2(-224,0)
	elif dir == "right":
		global_position = camera_pos + Vector2(224,0)
