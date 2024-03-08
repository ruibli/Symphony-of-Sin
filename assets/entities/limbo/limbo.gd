### Enemy.gd

extends CharacterBody2D

# Node refs
@onready var player

# Enemy stats
var speed = 75 * Glova.g_lap()
var health = 50 * Glova.g_lap()
var damage = 25 * Glova.g_lap()
var source = "enemy"
var can_hit = true
var active = false

func _physics_process(_delta):
	if active:
		player = Glova.g_pos()
		var player_distance = player - $LimboCollision.global_position
		velocity = player_distance.normalized()
		velocity = velocity.normalized() * speed
		move_and_slide()
		$LimboAnimation.global_position = $LimboCollision.global_position
		
		# Animation
		if velocity.y > 0 and abs(velocity.y) >= abs(velocity.x): #down
			$LimboAnimation.play("walk_down")
		elif velocity.y < 0 and abs(velocity.y) >= abs(velocity.x): #up
			$LimboAnimation.play("walk_up")
		elif velocity.x < 0 and abs(velocity.x) > abs(velocity.y): #left
			$LimboAnimation.play("walk_left")
		elif velocity.x > 0 and abs(velocity.x) > abs(velocity.y): #right
			$LimboAnimation.play("walk_right")
		
		for i in range(get_slide_collision_count()):
			var collision = get_slide_collision(i)
			if "damage" in collision.get_collider() and can_hit == true:
				if collision.get_collider().source == "nova":
					health -= collision.get_collider().damage
					can_hit = false
					$HitCooldown.start()
		if health <= 0:
			await get_tree().process_frame # wait for next frame; both arrow and limbo delete on contact and not just one or the other
			queue_free()
			Glova.g_enemies(-1)

func _on_visible_on_screen_notifier_2d_screen_exited():
	Glova.g_enemies(-1)

func _on_visible_on_screen_notifier_2d_screen_entered():
	active = true
	Glova.g_enemies(1)

func _on_hit_cooldown_timeout():
	can_hit = true
