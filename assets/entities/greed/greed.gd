extends CharacterBody2D

@export var coin_scene : PackedScene

# Enemy stats
var mod = 1 + 0.1 * (Glova.g_mod())

var speed = 50 * mod

var health = 50 * mod
var damage = 10 * mod

var active = false
var wait = false
var distance = 0
var see = false

var can_hit = true
var can_attack = true
var type = "move"
var direction = "down"

func sight():
	if $RayUp.is_colliding():
		if $RayUp.get_collider().name == "novahurt":
			direction = "up"
			return true
	if $RayDown.is_colliding():
		if $RayDown.get_collider().name == "novahurt":
			direction = "down"
			return true
	if $RayLeft.is_colliding():
		if $RayLeft.get_collider().name == "novahurt":
			direction = "left"
			return true
	if $RayRight.is_colliding():
		if $RayRight.get_collider().name == "novahurt":
			direction = "right"
			return true
	return false

func _physics_process(_delta):
	if active:
		distance = global_position.distance_to(Glova.g_pos())
		see = sight()
		
		if !wait:
			await get_tree().create_timer(0.25).timeout
			wait = true
		elif distance <= 136 and see:
			weapon()
		elif distance >= 128 or not see:
			$NavigationAgent2D.set_target_position(Glova.g_pos())
			var current_agent_position = global_position
			var next_path_position = $NavigationAgent2D.get_next_path_position()
			velocity = (next_path_position - current_agent_position).normalized() * speed
			$NavigationAgent2D.set_velocity(velocity)
		
		# Animation
		var nova_dir = Glova.g_pos() - global_position
		if type == "wait" and distance <= 128:
			if direction == "up":
				$GreedCollision/GreedAnimation.play("move_up")
			elif direction == "down":
				$GreedCollision/GreedAnimation.play("move_down")
			elif direction == "left":
				$GreedCollision/GreedAnimation.play("move_left")
			elif direction == "right":
				$GreedCollision/GreedAnimation.play("move_right")
		elif type == "move":
			if velocity.y < 0 and abs(velocity.y) > abs(velocity.x): #up
				$GreedCollision/GreedAnimation.play("move_up")
			elif velocity.y > 0 and abs(velocity.y) > abs(velocity.x): #down
				$GreedCollision/GreedAnimation.play("move_down")
			elif velocity.x < 0 and abs(velocity.x) > abs(velocity.y): #left
				$GreedCollision/GreedAnimation.play("move_left")
			elif velocity.x > 0 and abs(velocity.x) > abs(velocity.y): #right
				$GreedCollision/GreedAnimation.play("move_right")
		elif type == "attack":
			if nova_dir.y < 0 and abs(nova_dir.y) > abs(nova_dir.x): #up
				$WeaponPos.position = Vector2(0,-5)
				$WeaponPos.rotation_degrees = 180
				$GreedCollision/GreedAnimation.play("attack_up")
			elif nova_dir.y > 0 and abs(nova_dir.y) > abs(nova_dir.x): #down
				$WeaponPos.position = Vector2(0,15)
				$WeaponPos.rotation_degrees = 0
				$GreedCollision/GreedAnimation.play("attack_down")
			elif nova_dir.x < 0 and abs(nova_dir.x) > abs(nova_dir.y): #left
				$WeaponPos.position = Vector2(-10,5)
				$WeaponPos.rotation_degrees = 90
				$GreedCollision/GreedAnimation.play("attack_left")
			elif nova_dir.x > 0 and abs(nova_dir.x) > abs(nova_dir.y): #right
				$WeaponPos.position = Vector2(10,5)
				$WeaponPos.rotation_degrees = 270
				$GreedCollision/GreedAnimation.play("attack_right")
	
		$WeaponCooldown.wait_time = 1 * 1.0 / mod

func weapon():
	if can_attack:
		$WeaponCooldown.start()
		can_attack = false
		type = "attack"
		
		var w = coin_scene.instantiate()
		w.damage = w.damage * mod
		
		if direction == "up":
			$WeaponPos.position = Vector2(0,-10)
			$WeaponPos.rotation_degrees = 180
			$GreedCollision/GreedAnimation.play("attack_up")
			w.velocity.y -= 1
			w.rotation_degrees = 180
		elif direction == "down":
			$WeaponPos.position = Vector2(0,10)
			$WeaponPos.rotation_degrees = 0
			$GreedCollision/GreedAnimation.play("attack_down")
			w.velocity.y += 1
			w.rotation_degrees = 0
		elif direction == "left":
			$WeaponPos.position = Vector2(-10,0)
			$WeaponPos.rotation_degrees = 90
			$GreedCollision/GreedAnimation.play("attack_left")
			w.velocity.x -= 1
			w.rotation_degrees = 90
		elif direction == "right":
			$WeaponPos.position = Vector2(10,0)
			$WeaponPos.rotation_degrees = 270
			$GreedCollision/GreedAnimation.play("attack_right")
			w.velocity.x += 1
			w.rotation_degrees = 270
		await get_tree().create_timer(0.25).timeout
		w.global_position = $WeaponPos.global_position
		get_tree().root.add_child(w)
		await get_tree().create_timer(0.75).timeout
		type = "wait"

func _on_visible_on_screen_notifier_2d_screen_exited():
	active = false
	wait = false
	Glova.g_enemies(-1)

func _on_visible_on_screen_notifier_2d_screen_entered():
	active = true
	wait = false
	Glova.g_enemies(1)

func _on_hit_cooldown_timeout():
	can_hit = true
	$greedhurt.set_collision_layer_value(3,true)

func hit(ow):
	if can_hit:
		can_hit = false
		$greedhurt.set_collision_layer_value(3,false)
		$HitCooldown.start()
		health -= ow
		
		$GreedCollision/GreedAnimation/AnimationPlayer.play("hurt")
		if health <= 0:
			await get_tree().create_timer(0.05).timeout
			Glova.g_enemies(-1)
			queue_free()
		else:
			$GreedCollision/GreedAnimation/AnimationPlayer.play("clear")

func _on_greedhit_hurt_area_entered(area):
		area.hit(damage)

func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	if active and (distance >= 128 or not see):
		velocity = safe_velocity.normalized() * speed
		move_and_slide()

func _on_weapon_cooldown_timeout():
	can_attack = true
	type = "move"

func is_active():
	return active
