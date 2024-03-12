extends CharacterBody2D

var speed = 150
var damage = 20

func start(direction):
	velocity = Vector2.ZERO
	# Player Movement
	if direction == "up":
		velocity.y -= 1
	elif direction == "down":
		velocity.y += 1
	elif direction == "left":
		velocity.x -= 1
	elif direction == "right":
		velocity.x += 1

func _process(_delta):
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	move_and_slide()
	
	if velocity.y < 0: #down
		rotation_degrees = 180
	elif velocity.x > 0: #left
		rotation_degrees = 270
	elif velocity.x < 0: #right
		rotation_degrees = 90
	
	for index in get_slide_collision_count():
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_arrow_hit_area_entered(area):
		area.hit(damage)
		queue_free()
