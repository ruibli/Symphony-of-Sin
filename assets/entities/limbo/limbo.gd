### Enemy.gd

extends CharacterBody2D

# Node refs
@onready var player

# Enemy stats
var lap = 1 + 0.25 * (Glova.g_lap()-1)
var speed = 125 * lap
var health = 50 * lap
var damage = 25 * lap
var can_hit = true
var active = false

func _physics_process(_delta):
	if active:
		player = Glova.g_pos()
		var player_distance = player - $LimboCollision.global_position
		velocity = player_distance.normalized()
		velocity = velocity.normalized() * speed
		move_and_slide()
		global_position = $LimboCollision.global_position
		
		# Animation
		if velocity.y > 0 and abs(velocity.y) >= abs(velocity.x): #down
			$LimboAnimation.play("walk_down")
		elif velocity.y < 0 and abs(velocity.y) >= abs(velocity.x): #up
			$LimboAnimation.play("walk_up")
		elif velocity.x < 0 and abs(velocity.x) > abs(velocity.y): #left
			$LimboAnimation.play("walk_left")
		elif velocity.x > 0 and abs(velocity.x) > abs(velocity.y): #right
			$LimboAnimation.play("walk_right")
					
		if health <= 0:
			queue_free()
			Glova.g_enemies(-1)

func _on_visible_on_screen_notifier_2d_screen_exited():
	active = false
	Glova.g_enemies(-1)

func _on_visible_on_screen_notifier_2d_screen_entered():
	active = true
	Glova.g_enemies(1)

func _on_hit_cooldown_timeout():
	can_hit = true

func hit(ow):
	if can_hit:
		health -= ow
		can_hit = false
		$HitCooldown.start()

func _on_limbohit_hurt_area_entered(area):
	if area.is_in_group("nova"):
		area.hit(damage)
