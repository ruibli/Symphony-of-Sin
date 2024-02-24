extends Area2D

@export var speed = 15
var velocity = Vector2.ZERO

func start(pos,dir):
	$Arrow.position = pos
	# Player Movement
	if dir == "right":
		velocity.x += 1
	if dir == "left":
		velocity.x -= 1
	if dir == "down":
		velocity.y += 1
	if dir == "up":
		velocity.y -= 1

func _process(delta):
	velocity = velocity.normalized() * speed
	$Arrow.global_position += velocity * delta * speed
	
	if velocity.x < 0: #right
		$Arrow.rotation_degrees = 90
	elif velocity.x > 0: #left
		$Arrow.rotation_degrees = 270
	elif velocity.y < 0: #down
		$Arrow.rotation_degrees = 180
	elif velocity.y > 0: #up
		$Arrow.rotation_degrees = 360

func _on_area_entered(area):
	if area.is_in_group("enemies"):
		area.explode()
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
