### Enemy.gd

extends CharacterBody2D

# Enemy stats
var mod = 1 + 0.1 * (Glova.g_mod())
var speed = 125 * mod
var health = 50 * mod
var damage = 10 * mod
var attack = 1

var active = false
var wait = false
var distance = 0
var see = false

var can_hit = true
var can_attack = true
var direction = "down"
var type = "move"

func sight():
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(global_position, Glova.g_pos() + Vector2(0,9))
	var sight_check = space_state.intersect_ray(query)
	if sight_check:
		if sight_check.collider.name == "nova":
			return true
	return false

func _physics_process(_delta):
	if active:
		distance = global_position.distance_to(Glova.g_pos())
		see = sight()
		
		if not wait:
			await get_tree().create_timer(0.25).timeout
			wait = true
		elif (distance >= 24 or not see):
			$NavigationAgent2D.set_target_position(Glova.g_pos())
			var current_agent_position = global_position
			var next_path_position = $NavigationAgent2D.get_next_path_position()
			velocity = (next_path_position - current_agent_position).normalized() * speed
			$NavigationAgent2D.set_velocity(velocity)
		
		# Animation
		if type == "move":
			if velocity.y < 0 and abs(velocity.y) > abs(velocity.x): #up
				$LimboCollision/LimboAnimation.play("walk_up")
				direction = "up"
			elif velocity.y > 0 and abs(velocity.y) > abs(velocity.x): #down
				$LimboCollision/LimboAnimation.play("walk_down")
				direction = "down"
			elif velocity.x < 0 and abs(velocity.x) > abs(velocity.y): #left
				$LimboCollision/LimboAnimation.play("walk_left")
				direction = "left"
			elif velocity.x > 0 and abs(velocity.x) > abs(velocity.y): #right
				$LimboCollision/LimboAnimation.play("walk_right")
				direction = "right"
			
		if (distance <= 32 and see):
			weapon()
					
		if health <= 0:
			queue_free()
			Glova.g_enemies(-1)
		$WeaponCooldown.wait_time = 1.0 / attack

func weapon():
	if can_attack:
		$WeaponCooldown.start()
		can_attack = false
		type = "attack"
		if direction == "up":
			$LimboCollision/LimboAnimation.play("attack_up")
		elif direction == "down":
			$LimboCollision/LimboAnimation.play("attack_down")
		elif direction == "left":
			$LimboCollision/LimboAnimation.play("attack_left")
		elif direction == "right":
			$LimboCollision/LimboAnimation.play("attack_right")
		await get_tree().create_timer(1).timeout
		type = "move"

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
	$limbohurt.set_collision_layer_value(3,true)

func hit(ow):
	if can_hit:
		can_hit = false
		$limbohurt.set_collision_layer_value(3,false)
		$HitCooldown.start()
		health -= ow

func _on_limbohit_hurt_area_entered(area):
		area.hit(damage)

func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	if active and (distance >= 24 or not see):
		velocity = safe_velocity.normalized() * speed
		move_and_slide()

func _on_weapon_cooldown_timeout():
	can_attack = true
