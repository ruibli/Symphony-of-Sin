### Enemy.gd

extends CharacterBody2D

# Node refs
@onready var player

# Enemy stats
var mod = 1 + 0.1 * (Glova.g_mod())
var speed = 125 * mod
var health = 50 * mod
var damage = 10 * mod
var attack = 1

var active = false
var wait = false
var distance = 0

var can_hit = true
var direction = "down"
var type = "move"

func _physics_process(_delta):
	if active:
		distance = global_position.distance_to(Glova.g_pos())
		if not wait:
			await get_tree().create_timer(0.25).timeout
			wait = true
		elif distance >= 24:
			$NavigationAgent2D.set_target_position(Glova.g_pos())
			var current_agent_position = global_position
			var next_path_position = $NavigationAgent2D.get_next_path_position()
			velocity = (next_path_position - current_agent_position).normalized() * speed
			move_and_slide()
		
		# Animation
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
		
		if health <= 0:
			queue_free()
			Glova.g_enemies(-1)
		$AttackCooldown.wait_time = 1.0 / attack

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
	$Gluttonyhurt.set_collision_layer_value(3,true)

func hit(ow):
	if can_hit:
		can_hit = false
		$Gluttonyhurt.set_collision_layer_value(3,false)
		$HitCooldown.start()
		health -= ow

func _on_gluttonyhit_hurt_area_entered(area):
		area.hit(damage)
