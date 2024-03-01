### Enemy.gd

extends CharacterBody2D

# Node refs
@onready var player

# Enemy stats
@export var speed = 50
var direction : Vector2 # current direction
var new_direction = Vector2(0,1) # next direction

# Direction timer
var rng = RandomNumberGenerator.new()
var timer = 0
var active = false

func _physics_process(_delta):
	if active:
		player = Glova.get_pos()
		var player_distance = player - $LimboCollision.global_position
		velocity = player_distance.normalized()
		velocity = velocity.normalized() * speed
		move_and_slide()
		$LimboArmAnim.global_position = $LimboCollision.global_position
		$LimboBodyAnim.global_position = $LimboCollision.global_position

		#if the enemy collides with other objects, turn them around and re-randomize the timer countdown
		#if collision != null and collision.get_collider().name != "nova":
			#direction rotation
		#	direction = direction.rotated(rng.randf_range(PI/4, PI/2))
			#timer countdown random range
		#	timer = rng.randf_range(2, 5)
		#if they collide with the player trigger the timer's timeout() so that they can move toward the player
		#else:
		#	timer = 0

func _on_visible_on_screen_notifier_2d_screen_exited():
	active = false
	Glova.change_enemies(-1)

func _on_visible_on_screen_notifier_2d_screen_entered():
	active = true
	Glova.change_enemies(1)
