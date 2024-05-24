extends CharacterBody2D

@export var trident_scene : PackedScene
@export var bite_scene : PackedScene
@export var coin_scene : PackedScene
@export var greataxe_scene : PackedScene
@export var lava_scene : PackedScene
@export var beam_scene : PackedScene

var mod = 1 + 0.1 * (Glova.mod)
var enemy = "limbo"

var stats = []
var health = 50 * mod
var speed = 50 * mod
var attack = 1.5 / mod
var target = 20

var damage = 10 * mod

var active = false
var wait = false
var distance = 0
var see = false

var can_hit = true
var can_weapon = true
var w
var type = "move"
var direction = "down"

func _ready():
	#var enemies = ["limbo"]
	var enemies = ["limbo","gluttony","greed","wrath","heresy"]
	enemy = enemies[randi() % enemies.size()]
	
	# health, speed, attack, target
	if enemy == "limbo":
		stats = [50,50,1.5,20]
	elif enemy == "gluttony":
		stats = [25,75,1,20]
	elif enemy == "greed":
		stats = [50,50,1,128]
	elif enemy == "wrath":
		stats = [100,30,2,20]
	elif enemy == "heresy":
		stats = [65,65,3,64]
	elif enemy == "pride":
		pass
	
	health = stats[0] * mod	
	speed = stats[1] * mod
	attack = stats[2] / mod
	target = stats[3]
	$WeaponCooldown.wait_time = attack
	$EnemyCollision/EnemyAnimation.speed_scale = mod
	$EnemyCollision/EnemyAnimation.play(enemy+"_"+type+"_"+direction)
	
func sight():
	if $RayUp.is_colliding() and $RayUp2.is_colliding():
		if $RayUp.get_collider().name == "novahurt" and $RayUp2.get_collider().name == "novahurt":
			direction = "up"
			return true
	if $RayDown.is_colliding() and $RayDown2.is_colliding():
		if $RayDown.get_collider().name == "novahurt" and $RayDown2.get_collider().name == "novahurt":
			direction = "down"
			return true
	if $RayLeft.is_colliding() and $RayLeft2.is_colliding():
		if $RayLeft.get_collider().name == "novahurt" and $RayLeft2.get_collider().name == "novahurt":
			direction = "left"
			return true
	if $RayRight.is_colliding() and $RayRight2.is_colliding():
		if $RayRight.get_collider().name == "novahurt" and $RayRight2.get_collider().name == "novahurt":
			direction = "right"
			return true
	return false

func _physics_process(_delta):
	if active:
		distance = global_position.distance_to(Glova.pos)
		see = sight()
		
		if !wait:
			await get_tree().create_timer(0.25).timeout
			wait = true
		elif distance <= target + 8 and see:
			if can_weapon:
				if enemy == "limbo":
					w = trident_scene.instantiate()
					weapon(false,0.25)
				elif enemy == "gluttony":
					w = bite_scene.instantiate()
					weapon(false,0.25)
				elif enemy == "greed":
					w = coin_scene.instantiate()
					weapon(true,0)
				elif enemy == "wrath":
					w = greataxe_scene.instantiate()
					weapon(false,0.25)
				elif enemy == "heresy":
					w = lava_scene.instantiate()
					weapon(true,0)
		elif distance >= target or not see:
			$NavigationAgent2D.set_target_position(Glova.pos)
			var current_agent_position = global_position
			var next_path_position = $NavigationAgent2D.get_next_path_position()
			velocity = (next_path_position - current_agent_position).normalized() * speed
			$NavigationAgent2D.set_velocity(velocity)
		
		# Animation
		var nova_dir = Glova.pos - global_position
		if type == "move":
			if velocity.y < 0 and abs(velocity.y) > abs(velocity.x):
				direction = "up"
			elif velocity.y > 0 and abs(velocity.y) > abs(velocity.x):
				direction = "down"
			elif velocity.x < 0 and abs(velocity.x) > abs(velocity.y):
				direction = "left"
			elif velocity.x > 0 and abs(velocity.x) > abs(velocity.y):
				direction = "right"
		elif type == "attack":
			if nova_dir.y < 0 and abs(nova_dir.y) > abs(nova_dir.x):
				direction = "up"
			elif nova_dir.y > 0 and abs(nova_dir.y) > abs(nova_dir.x):
				direction = "down"
			elif nova_dir.x < 0 and abs(nova_dir.x) > abs(nova_dir.y):
				direction = "left"
			elif nova_dir.x > 0 and abs(nova_dir.x) > abs(nova_dir.y):
				direction = "right"
		$EnemyCollision/EnemyAnimation.play(enemy+"_"+type+"_"+direction)

func weapon(projectile, fire):
	$WeaponCooldown.start()
	can_weapon = false
	type = "attack"
	
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
	
	w.damage = w.damage * mod
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
	
	if !projectile:
		$WeaponPos.add_child(w)
	else:
		w.global_position = $WeaponPos.global_position
		get_tree().root.add_child(w)
	await get_tree().create_timer((1-fire)/attack).timeout
	type = "move"

func _on_visible_on_screen_notifier_2d_screen_exited():
	active = false
	wait = false
	Glova.enemies -= 1

func _on_visible_on_screen_notifier_2d_screen_entered():
	active = true
	wait = false
	Glova.enemies += 1

func _on_hit_cooldown_timeout():
	can_hit = true

func hit(ow,pos):	
	if can_hit:
		can_hit = false
		$HitCooldown.start()
		health -= ow
		
		if pos.distance_to(Glova.pos) < 64:
			Glova.sins = Glova.sins + (64 - pos.distance_to(Glova.pos))/64 * ow * 0.02
		
		#ON HIT STUFF HERE
		
		$EnemyCollision/EnemyAnimation/AnimationPlayer.play("hurt")
		if health <= 0:
			await get_tree().create_timer(0.05).timeout
			Glova.enemies -= 1
			queue_free()
		else:
			$EnemyCollision/EnemyAnimation/AnimationPlayer.play("clear")
		

func _on_enemyhurt_area_entered(area):
		area.hit(damage,global_position)

func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	if active and (distance >= target or not see):
		velocity = safe_velocity.normalized() * speed
		move_and_slide()

func _on_weapon_cooldown_timeout():
	can_weapon = true

func is_active():
	return active
