extends CharacterBody2D

@onready var camera_pos = Vector2(0,0)
var cam = false

@export var crossbow_scene : PackedScene
@export var spear_scene : PackedScene
@export var axe_scene : PackedScene
@export var homer_scene : PackedScene
@export var gauntlets_scene : PackedScene
@export var molotov_scene : PackedScene
@export var antlers_scene : PackedScene

var health = 100
var health_max = 100
var speed = 1
var power = 1
var attack = 1
var gold = 0

var inv = []
var hotbar = ["gauntlets", "crossbow", "empty", "empty", "empty", "empty", "empty"]
var current = "gauntlets"

var direction = "down"
var type = "move"
var foot = true
var lock = false
var lock2 = false
var can_hit = true

var w
var can_crossbow = true
var can_spear = true
var can_axe = true
var can_homer = true
var can_gauntlets = true
var can_molotov = true
var can_antlers = true

func set_nova():
	health = Glova.stats[0]
	health_max = Glova.stats[1]
	speed = Glova.stats[2]
	power = Glova.stats[3]
	attack = Glova.stats[4]
	gold = Glova.stats[5]
	
	inv = Glova.inv.duplicate()
	hotbar = Glova.hotbar.duplicate()
	current = Glova.current
	
	if health > health_max:
		Glova.stats[0] = health_max
	if health_max < 5:
		Glova.stats[1] = 5
	if speed < 0.5:
		Glova.stats[2] = 0.5
	if power < 0.5:
		Glova.stats[3] = 0.5
	if attack < 0.5:
		Glova.stats[4] = 0.5
	
	Glova.type = type
	Glova.pos = global_position
	$Camera2D.global_position = camera_pos
	$Camera2D.position_smoothing_enabled = cam
	
	$NovaCollision/NovaAnimation.speed_scale = attack
	$CrossbowCooldown.wait_time = 1.0 / attack
	$SpearCooldown.wait_time = 1.5 / attack
	$AxeCooldown.wait_time = 2.0 / attack
	$HomerCooldown.wait_time = 1.0 / attack
	$GauntletsCooldown.wait_time = 1.0 / attack
	$MolotovCooldown.wait_time = 1.0 / attack
	$AntlersCooldown.wait_time = 6.0 / attack
	
func _process(_delta):
	velocity = Vector2(0,0)
	if !lock:
		type = "move"
	
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
	
	if !lock2 and type == "attack" and (Input.is_action_pressed("attack_up") or Input.is_action_pressed("attack_down") or Input.is_action_pressed("attack_left") or Input.is_action_pressed("attack_right")):
		if current == "crossbow" and can_crossbow and Glova.sins > 0:
			w = crossbow_scene.instantiate()
			weapon(true,0)
		elif current == "spear" and can_spear:
			w = spear_scene.instantiate()
			weapon(false,0.25)
		elif current == "axe" and can_axe:
			w = axe_scene.instantiate()
			weapon(false,0.25)
		elif current == "homer" and can_homer and Glova.sins > 0:
			w = homer_scene.instantiate()
			weapon(true,0)
		elif current == "gauntlets" and can_gauntlets:
			w = gauntlets_scene.instantiate()
			weapon(false,0.25)
		elif current == "molotov" and can_molotov and Glova.sins > 0:
			w = molotov_scene.instantiate()
			weapon(true,0)
		elif current == "antlers" and can_antlers and Glova.sins > 0:
			w = antlers_scene.instantiate()
			weapon(true,0.83)
		elif !lock:
			type = "move"
	
	$NovaCollision/NovaAnimation.play(current+"_"+type+"_"+direction)
	if velocity.length() > 0 and foot:
		$NovaCollision/NovaAnimation.frame = 1
		foot = false

func weapon(projectile, fire): # attacking
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
	
	var save = current
	w.damage = w.damage * power
	$NovaCollision/NovaAnimation.play(current+"_"+type+"_"+direction)
	
	lock = true
	lock2 = true
	await get_tree().create_timer(fire/attack).timeout
	
	if direction == "up":
		$WeaponPos.position = Vector2(0,-10)
		$WeaponPos.rotation_degrees = 180
	elif direction == "down":
		$WeaponPos.position = Vector2(0,10)
		$WeaponPos.rotation_degrees = 0
	elif direction == "left":
		$WeaponPos.position = Vector2(-10,0)
		$WeaponPos.rotation_degrees = 90
	elif direction == "right":
		$WeaponPos.position = Vector2(10,0)
		$WeaponPos.rotation_degrees = 270
		
	if save == current:
		if !projectile:
			$WeaponPos.add_child(w)
		else:
			w.global_position = $WeaponPos.global_position
			get_tree().root.add_child(w)
		
		if current == "crossbow":
			can_crossbow = false
			$CrossbowCooldown.start()
			Glova.cooldown = $CrossbowCooldown.wait_time
		elif current == "spear":
			can_spear = false
			$SpearCooldown.start()
			Glova.cooldown = $SpearCooldown.wait_time
		elif current == "axe":
			can_axe = false
			$AxeCooldown.start()
			Glova.cooldown = $AxeCooldown.wait_time
		elif current == "homer":
			can_homer = false
			$HomerCooldown.start()
			Glova.cooldown = $HomerCooldown.wait_time
		elif current == "gauntlets":
			can_gauntlets = false
			$GauntletsCooldown.start()
			Glova.cooldown = $GauntletsCooldown.wait_time
		elif current == "molotov":
			can_molotov = false
			$MolotovCooldown.start()
			Glova.cooldown = $MolotovCooldown.wait_time
		elif current == "antlers":
			can_antlers = false
			$AntlersCooldown.start()
			Glova.cooldown = $AntlersCooldown.wait_time
		
		lock2 = false
		await get_tree().create_timer((1-fire)/attack).timeout
		lock = false
		
	else:
		lock2 = false
		lock = false

func _on_room_detector_area_entered(area: Area2D) -> void: #camera stuff
	if area.get_name() == 'CameraArea':
		var collision_shape = area.get_node("CollisionShape2D")
		camera_pos = collision_shape.global_position

func _on_hit_cooldown_timeout():
	can_hit = true

func hit(ow,_pos):
	if can_hit:
		can_hit = false
		$HitCooldown.start()
		Glova.change([-ow, 0, 0, 0, 0, 0])
		
		#ON HIT STUFF HERE
		
		$NovaCollision/NovaAnimation/AnimationPlayer.play("hurt")
		if Glova.stats[0] <= 0:
			await get_tree().create_timer(0.05).timeout
			Glova.level = -1
		else:
			$NovaCollision/NovaAnimation/AnimationPlayer.play("clear")

func boop(dir):
	if dir == "up":
		global_position = camera_pos + Vector2(0,-230)
	elif dir == "down":
		global_position = camera_pos + Vector2(0,230)
	elif dir == "left":
		global_position = camera_pos + Vector2(-230,0)
	elif dir == "right":
		global_position = camera_pos + Vector2(230,0)

func _on_crossbow_cooldown_timeout(): # bow cooldown
	can_crossbow = true

func _on_spear_cooldown_timeout():
	can_spear = true

func _on_axe_cooldown_timeout():
	can_axe = true

func _on_homer_cooldown_timeout():
	can_homer = true

func _on_gauntlets_cooldown_timeout():
	can_gauntlets = true

func _on_molotov_cooldown_timeout():
	can_molotov = true

func _on_antlers_cooldown_timeout():
	can_antlers = true
