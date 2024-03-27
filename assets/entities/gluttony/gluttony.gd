### Enemy.gd

extends CharacterBody2D

@export var bite_scene : PackedScene

# Enemy stats
var mod = 1 + 0.1 * (Glova.g_mod())

var speed = 75 * mod

var health = 25 * mod
var damage = 10 * mod
var attack = 1 * mod

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
		
		if not wait:
			await get_tree().create_timer(0.25).timeout
			wait = true
		elif distance <= 24 and see:
			weapon()
		elif distance >= 16 or not see:
			$NavigationAgent2D.set_target_position(Glova.g_pos())
			var current_agent_position = global_position
			var next_path_position = $NavigationAgent2D.get_next_path_position()
			velocity = (next_path_position - current_agent_position).normalized() * speed
			$NavigationAgent2D.set_velocity(velocity)
		
		# Animation
		var nova_dir = Glova.g_pos() - global_position
		if type == "wait" and distance <= 24:
			if direction == "up":
				$GluttonyCollision/GluttonyAnimation.play("walk_up")
				$GluttonyCollision/GluttonyAnimation.flip_h = false
			elif direction == "down":
				$GluttonyCollision/GluttonyAnimation.play("walk_down")
				$GluttonyCollision/GluttonyAnimation.flip_h = false
			elif direction == "left":
				$GluttonyCollision/GluttonyAnimation.play("walk_right")
				$GluttonyCollision/GluttonyAnimation.flip_h = true
			elif direction == "right":
				$GluttonyCollision/GluttonyAnimation.play("walk_right")
				$GluttonyCollision/GluttonyAnimation.flip_h = false
		elif type == "move":
			if velocity.y < 0 and abs(velocity.y) > abs(velocity.x): #up
				$GluttonyCollision/GluttonyAnimation.play("walk_up")
				$GluttonyCollision/GluttonyAnimation.flip_h = false
			elif velocity.y > 0 and abs(velocity.y) > abs(velocity.x): #down
				$GluttonyCollision/GluttonyAnimation.play("walk_down")
				$GluttonyCollision/GluttonyAnimation.flip_h = false
			elif velocity.x < 0 and abs(velocity.x) > abs(velocity.y): #left
				$GluttonyCollision/GluttonyAnimation.play("walk_right")
				$GluttonyCollision/GluttonyAnimation.flip_h = true
			elif velocity.x > 0 and abs(velocity.x) > abs(velocity.y): #right
				$GluttonyCollision/GluttonyAnimation.play("walk_right")
				$GluttonyCollision/GluttonyAnimation.flip_h = false
		elif type == "attack":
			if nova_dir.y < 0 and abs(nova_dir.y) > abs(nova_dir.x): #up
				$WeaponPos.position = Vector2(0,-10)
				$WeaponPos.rotation_degrees = 180
				$GluttonyCollision/GluttonyAnimation.play("attack_up")
				$GluttonyCollision/GluttonyAnimation.flip_h = false
			elif nova_dir.y > 0 and abs(nova_dir.y) > abs(nova_dir.x): #down
				$WeaponPos.position = Vector2(0,10)
				$WeaponPos.rotation_degrees = 0
				$GluttonyCollision/GluttonyAnimation.play("attack_down")
				$GluttonyCollision/GluttonyAnimation.flip_h = false
			elif nova_dir.x < 0 and abs(nova_dir.x) > abs(nova_dir.y): #left
				$WeaponPos.position = Vector2(-10,0)
				$WeaponPos.rotation_degrees = 90
				$GluttonyCollision/GluttonyAnimation.play("attack_right")
				$GluttonyCollision/GluttonyAnimation.flip_h = true
			elif nova_dir.x > 0 and abs(nova_dir.x) > abs(nova_dir.y): #right
				$WeaponPos.position = Vector2(10,0)
				$WeaponPos.rotation_degrees = 270
				$GluttonyCollision/GluttonyAnimation.play("attack_right")
				$GluttonyCollision/GluttonyAnimation.flip_h = false
		
		$WeaponCooldown.wait_time = 1 * 1.0 / attack

func weapon():
	if can_attack:
		$WeaponCooldown.start()
		can_attack = false
		type = "attack"
		
		var w = bite_scene.instantiate()
		w.damage = w.damage * mod
		
		if direction == "up":
			$WeaponPos.position = Vector2(0,-10)
			$WeaponPos.rotation_degrees = 180
			$GluttonyCollision/GluttonyAnimation.play("attack_up")
			$GluttonyCollision/GluttonyAnimation.flip_h = false
		elif direction == "down":
			$WeaponPos.position = Vector2(0,10)
			$WeaponPos.rotation_degrees = 0
			$GluttonyCollision/GluttonyAnimation.play("attack_down")
			$GluttonyCollision/GluttonyAnimation.flip_h = false
		elif direction == "left":
			$WeaponPos.position = Vector2(-10,0)
			$WeaponPos.rotation_degrees = 90
			$GluttonyCollision/GluttonyAnimation.play("attack_right")
			$GluttonyCollision/GluttonyAnimation.flip_h = true
		elif direction == "right":
			$WeaponPos.position = Vector2(10,0)
			$WeaponPos.rotation_degrees = 270
			$GluttonyCollision/GluttonyAnimation.play("attack_right")
			$GluttonyCollision/GluttonyAnimation.flip_h = false
		await get_tree().create_timer(0.25).timeout
		$WeaponPos.add_child(w)
		await get_tree().create_timer(0.75).timeout
		type = "wait"

func _on_hit_cooldown_timeout():
	can_hit = true
	$gluttonyhurt.set_collision_layer_value(3,true)

func hit(ow):
	if can_hit:
		can_hit = false
		$gluttonyhurt.set_collision_layer_value(3,false)
		$HitCooldown.start()
		health -= ow
		
		var tween = get_tree().create_tween()
		tween.tween_property($GluttonyCollision/GluttonyAnimation, "modulate", Color(1, 0, 0, 1), 0.05)
		if health <= 0:
			await get_tree().create_timer(0.05).timeout
			Glova.g_enemies(-1)
			queue_free()
		else:
			tween.tween_property($GluttonyCollision/GluttonyAnimation, "modulate", Color(1, 1, 1, 1), 0.05)

func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	if active and (distance >= 16 or not see):
		velocity = safe_velocity.normalized() * speed
		move_and_slide()

func _on_weapon_cooldown_timeout():
	can_attack = true
	type = "move"	

func _on_gluttonyhurt_area_entered(area):
	area.hit(damage)

func _on_visible_on_screen_notifier_2d_screen_entered():
	active = true
	wait = false
	Glova.g_enemies(1)

func _on_visible_on_screen_notifier_2d_screen_exited():
	active = false
	wait = false
	Glova.g_enemies(-1)
