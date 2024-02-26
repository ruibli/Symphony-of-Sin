### Enemy.gd

extends CharacterBody2D

# Node refs
@onready var player = get_tree().root.get_node("Main/Player")

# Enemy stats
@export var speed = 50
var direction : Vector2 # current direction
var new_direction = Vector2(0,1) # next direction

# Direction timer
var rng = RandomNumberGenerator.new()
var timer = 0

func _ready():
	rng.randomize()

func _on_timer_timeout():
# distance of enemy to player
	var player_distance = player.position - position
	#turn to player if in its radius
	if player_distance.length() <= 20:
		new_direction = player_distance.normalized()
	#move toward player
	elif player_distance.length() <= 100 and timer == 0:
		direction = player_distance.normalized()
	#random roam
	elif timer == 0:
	#random direction
		var random_direction = rng.randf()
		if random_direction < 0.05:
			#enemy stops
			direction = Vector2.ZERO
		elif random_direction < 0.1:
			#enemy moves
			direction = Vector2.DOWN.rotated(rng.randf() * 2 * PI)

func _physics_process(delta):
	var movement = speed * direction * delta
	var collision = move_and_collide(movement)

	#if the enemy collides with other objects, turn them around and re-randomize the timer countdown
	if collision != null and collision.get_collider().name != "Player":
		#direction rotation
		direction = direction.rotated(rng.randf_range(PI/4, PI/2))
		#timer countdown random range
		timer = rng.randf_range(2, 5)
	#if they collide with the player trigger the timer's timeout() so that they can move toward the player
	else:
		timer = 0
