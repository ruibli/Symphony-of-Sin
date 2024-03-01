extends CharacterBody2D

@export var speed = 100
var weapon = "arrow"

func start(direction):
	velocity = Vector2.ZERO
	# Player Movement
	if direction == "right":
		velocity.x += 1
	elif direction == "left":
		velocity.x -= 1
	elif direction == "down":
		velocity.y += 1
	elif direction == "up":
		velocity.y -= 1

func _process(_delta):
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	move_and_slide()
	$Arrow.global_position = $CollisionShape2D.global_position
	
	if velocity.x < 0: #right
		$Arrow.rotation_degrees = 90
		$CollisionShape2D.rotation_degrees = 90
	elif velocity.x > 0: #left
		$Arrow.rotation_degrees = 270
		$CollisionShape2D.rotation_degrees = 270
	elif velocity.y < 0: #down
		$Arrow.rotation_degrees = 180
		$CollisionShape2D.rotation_degrees = 180
	elif velocity.y > 0: #up
		$Arrow.rotation_degrees = 0
		$CollisionShape2D.rotation_degrees = 0
		
	for index in get_slide_collision_count():
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
