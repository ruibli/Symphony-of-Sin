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

var direction = "down"
var type = "move"
var foot = true
var lock = false
var lock2 = false
var can_hit = true
var can_rotate = true
var knockback = Vector2(0,0)
var tween

var w
var can_crossbow = true
var can_spear = true
var can_axe = true
var can_homer = true
var can_gauntlets = true
var can_molotov = true
var can_antlers = true

func set_nova():
	if Glova.stats[0] > Glova.stats[1]:
		Glova.stats[0] = Glova.stats[1]
	
	Glova.pos = global_position
	$Camera2D.global_position = camera_pos
	$Camera2D.position_smoothing_enabled = cam
	
	$NovaCollision/NovaAnimation.speed_scale = Glova.stats[4]
	$CrossbowCooldown.wait_time = (1.0 - 0)/ Glova.stats[4]
	$SpearCooldown.wait_time = (1.5 - 0.25) / Glova.stats[4]
	$AxeCooldown.wait_time = (2.0 - 0.25) / Glova.stats[4]
	$HomerCooldown.wait_time = (1.0 - 0) / Glova.stats[4]
	$GauntletsCooldown.wait_time = (1.0 - 0.25) / Glova.stats[4]
	$MolotovCooldown.wait_time = (1.0 - 0) / Glova.stats[4]
	$AntlersCooldown.wait_time = (6.0 - 0.83) / Glova.stats[4]
	
func _process(_delta):
	velocity = Vector2(0,0)
	if !lock:
		type = "move"
	
	if knockback != Vector2(0,0):
		velocity = knockback * Glova.stats[2]
			
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
		if can_rotate:
			direction = "up"
			$WeaponPos.position = Vector2(0,-10)
			$WeaponPos.rotation_degrees = 180
	if Input.is_action_pressed("attack_down"):
		type = "attack"
		if can_rotate:
			direction = "down"
			$WeaponPos.position = Vector2(0,10)
			$WeaponPos.rotation_degrees = 0
	if Input.is_action_pressed("attack_left"):
		type = "attack"
		if can_rotate:
			direction = "left"
			$WeaponPos.position = Vector2(-10,0)
			$WeaponPos.rotation_degrees = 90
	if Input.is_action_pressed("attack_right"):
		type = "attack"
		if can_rotate:
			direction = "right"
			$WeaponPos.position = Vector2(10,0)
			$WeaponPos.rotation_degrees = 270
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * 100 * Glova.stats[2]
		$NovaCollision/NovaAnimation.play()
	elif type == "move":
		$NovaCollision/NovaAnimation.frame = 0
		$NovaCollision/NovaAnimation.stop()
		foot = true
	
	move_and_slide()
	set_nova()
	
	if type == "move" and can_rotate:
		if velocity.y < 0 and abs(velocity.y) > abs(velocity.x): #up
			direction = "up"
		elif velocity.y > 0 and abs(velocity.y) > abs(velocity.x): #down
			direction = "down"
		elif velocity.x < 0 and abs(velocity.x) > abs(velocity.y): #left
			direction = "left"
		elif velocity.x > 0 and abs(velocity.x) > abs(velocity.y): #right
			direction = "right"
	
	if !lock2 and type == "attack" and (Input.is_action_pressed("attack_up") or Input.is_action_pressed("attack_down") or Input.is_action_pressed("attack_left") or Input.is_action_pressed("attack_right")):
		if (Glova.current in Glova.ranged and Glova.sins > 0) or !(Glova.current in Glova.ranged):
			if Glova.current == "crossbow" and can_crossbow:
				w = crossbow_scene.instantiate()
				weapon(true,0)
			elif Glova.current == "spear" and can_spear:
				w = spear_scene.instantiate()
				weapon(false,0.22)
			elif Glova.current == "axe" and can_axe:
				w = axe_scene.instantiate()
				weapon(false,0)
			elif Glova.current == "homer" and can_homer:
				w = homer_scene.instantiate()
				weapon(true,0)
			elif Glova.current == "gauntlets" and can_gauntlets:
				w = gauntlets_scene.instantiate()
				weapon(false,0.37)
			elif Glova.current == "molotov" and can_molotov:
				w = molotov_scene.instantiate()
				weapon(true,0)
			elif Glova.current == "antlers" and can_antlers:
				w = antlers_scene.instantiate()
				weapon(false,0)
			elif !lock:
				type = "move"
	
	$NovaCollision/NovaAnimation.play(Glova.current+"_"+type+"_"+direction)
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
	
	var save = Glova.current
	w.damage = w.damage * Glova.stats[3]
	if !projectile:
		w.attack = Glova.stats[4]
	$NovaCollision/NovaAnimation.play(Glova.current+"_"+type+"_"+direction)
	
	lock = true
	lock2 = true
	await get_tree().create_timer(fire/Glova.stats[4]).timeout
	
	if direction == "up":
		$WeaponPos.position = Vector2(0,-10)
		$WeaponPos.rotation_degrees = 180
		w.dir = "up"
	elif direction == "down":
		$WeaponPos.position = Vector2(0,10)
		$WeaponPos.rotation_degrees = 0
		w.dir = "down"
	elif direction == "left":
		$WeaponPos.position = Vector2(-10,0)
		$WeaponPos.rotation_degrees = 90
		w.dir = "left"
	elif direction == "right":
		$WeaponPos.position = Vector2(10,0)
		$WeaponPos.rotation_degrees = 270
		w.dir = "right"
		
	if save == Glova.current:
		if !projectile:
			$WeaponPos.add_child(w)
		else:
			w.global_position = $WeaponPos.global_position
			get_tree().root.add_child(w)
		
		if Glova.current == "crossbow":
			can_crossbow = false
			$CrossbowCooldown.start()
			Glova.cooldown = $CrossbowCooldown.wait_time
		elif Glova.current == "spear":
			can_spear = false
			$SpearCooldown.start()
			Glova.cooldown = $SpearCooldown.wait_time
		elif Glova.current == "axe":
			can_axe = false
			$AxeCooldown.start()
			Glova.cooldown = $AxeCooldown.wait_time
		elif Glova.current == "homer":
			can_homer = false
			$HomerCooldown.start()
			Glova.cooldown = $HomerCooldown.wait_time
		elif Glova.current == "gauntlets":
			can_gauntlets = false
			$GauntletsCooldown.start()
			Glova.cooldown = $GauntletsCooldown.wait_time
		elif Glova.current == "molotov":
			can_molotov = false
			$MolotovCooldown.start()
			Glova.cooldown = $MolotovCooldown.wait_time
		elif Glova.current == "antlers":
			can_antlers = false
			$AntlersCooldown.start()
			Glova.cooldown = $AntlersCooldown.wait_time
		
		lock2 = false
		if Glova.current == "antlers":
			can_rotate = false
			await get_tree().create_timer((2-fire)/Glova.stats[4]).timeout
		else:
			await get_tree().create_timer((1-fire)/Glova.stats[4]).timeout
		lock = false
		can_rotate = true
		
	else:
		lock2 = false
		lock = false

func _on_room_detector_area_entered(area: Area2D) -> void: #camera stuff
	if area.get_name() == 'CameraArea':
		var collision_shape = area.get_node("CollisionShape2D")
		camera_pos = collision_shape.global_position

func _on_hit_cooldown_timeout():
	can_hit = true

func hit(ow,nam,dir):
	if can_hit and !("painting" in Glova.inv):
		can_hit = false
		$HitCooldown.start()
		$NovaCollision/NovaAnimation/AnimationPlayer.play("hurt")
		
		#ON DAMAGE STUFF HERE
		
		if nam == "bite":
			tween = get_tree().create_tween()
			if dir == "up":
				knockback = Vector2(0,-10)
			elif dir == "down":
				knockback = Vector2(0,10)
			elif dir == "left":
				knockback = Vector2(-10,0)
			elif dir == "right":
				knockback = Vector2(10,0)
			tween.tween_property(self, "knockback", Vector2(0,0), 0.5)
		
		if Glova.stats[0] - ow < 1:
			await get_tree().create_timer(0.05).timeout
			Glova.level = -1
		else:
			Glova.change([-ow, 0, 0, 0, 0, 0])
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
