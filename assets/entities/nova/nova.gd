extends CharacterBody2D

@onready var camera_pos = Vector2(0,0)
var cam = false

@export var crossbow_scene : PackedScene
@export var spear_scene : PackedScene
@export var axe_scene : PackedScene
@export var homer_scene : PackedScene

var health = 100
var health_max = 100
var speed = 1
var power = 1
var attack = 1
var gold = 0

var inv = []
var hotbar = ["crossbow", "empty", "empty", "empty", "empty", "empty", "empty"]
var current = "crossbow"

var direction = "down"
var type = "move"
var foot = true
var lock = false
var can_hit = true

var w
var can_crossbow = true
var can_spear = true
var can_axe = true
var can_homer = true

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
	
	$CrossbowCooldown.wait_time = 1.0 / attack
	$SpearCooldown.wait_time = 1.5 / attack
	$AxeCooldown.wait_time = 2.0 / attack
	
func _process(_delta):
	velocity = Vector2.ZERO
	if !lock:
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
		$WeaponPos.position = Vector2(0,-10)
		$WeaponPos.rotation_degrees = 180
	if Input.is_action_pressed("attack_down"):
		type = "attack"
		direction = "down"
		$WeaponPos.position = Vector2(0,10)
		$WeaponPos.rotation_degrees = 0
	if Input.is_action_pressed("attack_left"):
		type = "attack"
		direction = "left"
		$WeaponPos.position = Vector2(-10,0)
		$WeaponPos.rotation_degrees = 90
	if Input.is_action_pressed("attack_right"):
		type = "attack"
		direction = "right"
		$WeaponPos.position = Vector2(10,0)
		$WeaponPos.rotation_degrees = 270
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * 100 * speed
		$NovaCollision/NovaAnimation.play()
	elif type == "move":
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
	
	if type == "attack":
		if current == "crossbow" and can_crossbow:
			can_crossbow = false
			$CrossbowCooldown.start()
			Glova.g_cooldown($CrossbowCooldown.wait_time)
			w = crossbow_scene.instantiate()
			weapon(true,0)
		elif current == "spear" and can_spear:
			can_spear = false
			$SpearCooldown.start()
			Glova.g_cooldown($SpearCooldown.wait_time)
			w = spear_scene.instantiate()
			weapon(false,0)
		elif current == "axe" and can_axe:
			can_axe = false
			$AxeCooldown.start()
			Glova.g_cooldown($AxeCooldown.wait_time)
			w = axe_scene.instantiate()
			weapon(false,0)
		elif current == "homer" and can_homer:
			can_homer = false
			$HomerCooldown.start()
			Glova.g_cooldown($HomerCooldown.wait_time)
			w = homer_scene.instantiate()
			weapon(true,0)
		else:
			if !lock:
				type = "move"
	
	$NovaCollision/NovaAnimation.play(current+"_"+type+"_"+direction)
	if velocity.length() > 0 and foot:
		$NovaCollision/NovaAnimation.frame = 1
		foot = false

func weapon(projectile, delay): # attacking
	if projectile:
		if direction == "up":
			w.velocity.y -= 1
			w.rotation_degrees = 180
		elif direction == "down":
			w.velocity.y += 1
			w.rotation_degrees = 0
		elif direction == "left":
			w.velocity.x -= 1
			w.rotation_degrees = 90
		elif direction == "right":
			w.velocity.x += 1
			w.rotation_degrees = 270
	
	w.damage = w.damage * attack
	$NovaCollision/NovaAnimation.play(current+"_"+type+"_"+direction)
	
	if !projectile:
		lock = true
		await get_tree().create_timer(delay+0.25).timeout
		$WeaponPos.add_child(w)
		await get_tree().create_timer(0.75).timeout
		lock = false
	else:
		w.global_position = global_position
		get_tree().root.add_child(w)

func _on_room_detector_area_entered(area: Area2D) -> void: #camera stuff
	if area.get_name() == 'CameraArea':
		var collision_shape = area.get_node("CollisionShape2D")
		camera_pos = collision_shape.global_position

func _on_hit_cooldown_timeout():
	can_hit = true

func hit(ow):
	if can_hit:
		can_hit = false
		$HitCooldown.start()
		Glova.g_stats([-ow, 0, 0, 0, 0, 0])
		
		$NovaCollision/NovaAnimation/AnimationPlayer.play("hurt")
		if Glova.g_stats()[0] <= 0:
			await get_tree().create_timer(0.05).timeout
			Glova.g_level(-1)
		else:
			$NovaCollision/NovaAnimation/AnimationPlayer.play("clear")

func boop(dir):
	if dir == "up":
		global_position = camera_pos + Vector2(0,-224)
	elif dir == "down":
		global_position = camera_pos + Vector2(0,224)
	elif dir == "left":
		global_position = camera_pos + Vector2(-224,0)
	elif dir == "right":
		global_position = camera_pos + Vector2(224,0)

func _on_crossbow_cooldown_timeout(): # bow cooldown
	can_crossbow = true

func _on_spear_cooldown_timeout():
	can_spear = true

func _on_axe_cooldown_timeout():
	can_axe = true

func _on_homer_cooldown_timeout():
	can_homer = true
