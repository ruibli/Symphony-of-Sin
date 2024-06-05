extends CharacterBody2D

@export var trident_scene : PackedScene
@export var bite_scene : PackedScene
@export var coin_scene : PackedScene
@export var greataxe_scene : PackedScene
@export var lava_scene : PackedScene
@export var blast_scene : PackedScene

var mod = 1 + 0.1 * (Glova.mod)
var enemy = "enemy"

var stats = []

var active = false
var wait = false
var distance = 0
var see = false

var can_hit = true
var can_weapon = true
var can_rotate = true
var w
var type = "move"
var direction = "down"
var tween
var knockback = Vector2(0,0)

func _ready():
	#vard enemies = ["pride"]
	var enemies = ["limbo","gluttony","greed","wrath","heresy","pride"]
	if enemy == "enemy":
		enemy = enemies[randi() % enemies.size()]
	
	# health, speed, cooldown, target
	if enemy == "limbo":
		stats = [60,50,1.5,20]
	elif enemy == "gluttony":
		stats = [30,65,1,20]
	elif enemy == "greed":
		stats = [50,50,3,128]
	elif enemy == "wrath":
		stats = [100,30,2,20]
	elif enemy == "heresy":
		stats = [40,60,3,64]
	elif enemy == "pride":
		stats = [45,45,6,128]
	
	stats[0] = stats[0] * mod	
	stats[1] = stats[1] * mod
	$WeaponCooldown.wait_time = stats[2]
	$EnemyCollision/EnemyAnimation.speed_scale = mod
	$EnemyCollision/EnemyAnimation.play(enemy+"_"+type+"_"+direction)
	
func sight():
	if $RayUp.is_colliding() and $RayUp2.is_colliding():
		if $RayUp.get_collider().name == "novahurt" and $RayUp2.get_collider().name == "novahurt":
			if can_rotate:
				direction = "up"
			return true
	if $RayDown.is_colliding() and $RayDown2.is_colliding():
		if $RayDown.get_collider().name == "novahurt" and $RayDown2.get_collider().name == "novahurt":
			if can_rotate:
				direction = "down"
			return true
	if $RayLeft.is_colliding() and $RayLeft2.is_colliding():
		if $RayLeft.get_collider().name == "novahurt" and $RayLeft2.get_collider().name == "novahurt":
			if can_rotate:
				direction = "left"
			return true
	if $RayRight.is_colliding() and $RayRight2.is_colliding():
		if $RayRight.get_collider().name == "novahurt" and $RayRight2.get_collider().name == "novahurt":
			if can_rotate:
				direction = "right"
			return true
	return false

func _physics_process(_delta):
	if active:
		distance = global_position.distance_to(Glova.pos)
		see = sight()
		
		if !wait:
			await get_tree().create_timer(0.5).timeout
			wait = true
		else:
			if knockback != Vector2(0,0):
				velocity = knockback * stats[1]
				move_and_slide()
			if distance <= stats[3] + 8 and see:
				if can_weapon:
					if enemy == "limbo":
						w = trident_scene.instantiate()
						weapon(false,0.28)
					elif enemy == "gluttony":
						w = bite_scene.instantiate()
						weapon(false,0.2)
					elif enemy == "greed":
						w = coin_scene.instantiate()
						weapon(true,0)
					elif enemy == "wrath":
						w = greataxe_scene.instantiate()
						weapon(false,0)
					elif enemy == "heresy":
						w = lava_scene.instantiate()
						weapon(true,0)
					elif enemy == "pride":
						w = blast_scene.instantiate()
						weapon(false,0)
			elif distance >= stats[3] or not see:
				$NavigationAgent2D.set_target_position(Glova.pos)
				var current_agent_position = global_position
				var next_path_position = $NavigationAgent2D.get_next_path_position()
				velocity = (next_path_position - current_agent_position).normalized() * stats[1]
				$NavigationAgent2D.set_velocity(velocity)
		
		# Animation
		var nova_dir = Glova.pos - global_position
		if type == "move" and can_rotate:
			if velocity.y < 0 and abs(velocity.y) > abs(velocity.x):
				direction = "up"
			elif velocity.y > 0 and abs(velocity.y) > abs(velocity.x):
				direction = "down"
			elif velocity.x < 0 and abs(velocity.x) > abs(velocity.y):
				direction = "left"
			elif velocity.x > 0 and abs(velocity.x) > abs(velocity.y):
				direction = "right"
		elif type == "attack" and can_rotate:
			if nova_dir.y < 0 and abs(nova_dir.y) > abs(nova_dir.x):
				direction = "up"
				$WeaponPos.position = Vector2(0,-10)
				$WeaponPos.rotation_degrees = 180
			elif nova_dir.y > 0 and abs(nova_dir.y) > abs(nova_dir.x):
				direction = "down"
				$WeaponPos.position = Vector2(0,10)
				$WeaponPos.rotation_degrees = 0
			elif nova_dir.x < 0 and abs(nova_dir.x) > abs(nova_dir.y):
				direction = "left"
				$WeaponPos.position = Vector2(-10,0)
				$WeaponPos.rotation_degrees = 90
			elif nova_dir.x > 0 and abs(nova_dir.x) > abs(nova_dir.y):
				direction = "right"
				$WeaponPos.position = Vector2(10,0)
				$WeaponPos.rotation_degrees = 270
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
	if !projectile:
		w.attack = mod
	await get_tree().create_timer(fire/mod).timeout
	
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
	
	if !projectile:
		$WeaponPos.add_child(w)
	else:
		w.global_position = $WeaponPos.global_position
		get_tree().root.add_child(w)
		
	if enemy == "pride":
		can_rotate = false
		await get_tree().create_timer((2-fire)/mod).timeout
	else:
		await get_tree().create_timer((1-fire)/mod).timeout	
	type = "move"
	can_rotate = true

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

func hit(ow,nam,dir):	
	if can_hit and active:
		can_hit = false
		$HitCooldown.start()
		stats[0] -= ow
		
		# ON HIT HERE
		
		if global_position.distance_to(Glova.pos) < 64 and !(nam in Glova.ranged):
			Glova.sins = Glova.sins + (64 - global_position.distance_to(Glova.pos))/64 * ow * 0.02
		
		if nam == "homer":
			stats[0] = 0
		
		if nam == "gauntlets":
			tween = get_tree().create_tween()
			if dir == "up":
				knockback = Vector2(0,-5)
			elif dir == "down":
				knockback = Vector2(0,5)
			elif dir == "left":
				knockback = Vector2(-5,0)
			elif dir == "right":
				knockback = Vector2(5,0)
			tween.tween_property(self, "knockback", Vector2(0,0), 0.5)

		$EnemyCollision/EnemyAnimation/AnimationPlayer.play("hurt")
		if stats[0] <= 0:
			await get_tree().create_timer(0.05).timeout
			Glova.enemies -= 1
			queue_free()
		else:
			$EnemyCollision/EnemyAnimation/AnimationPlayer.play("clear")

func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	if active and (distance >= stats[3] or not see):
		velocity = (safe_velocity.normalized()) * stats[1]
		move_and_slide()

func _on_weapon_cooldown_timeout():
	can_weapon = true

func is_active():
	return active
