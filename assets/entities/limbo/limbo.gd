extends RigidBody2D

var speed = 200

func _ready():
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(mob_types[randi() % mob_types.size()])

func _process(delta):
	# change to momement ai
	var velocity = Vector2.ZERO 

	if velocity.length() >= 0:
		velocity = velocity.normalized() * speed
		$LimboBodyAnim.play()
		$LimboArmAnim.play()
	else:
		$LimboBodyAnim.stop()
		$LimboArmAnim.stop()
	
	$LimboBodyAnim.position += velocity * delta
	$LimboArmAnim.position += velocity * delta

	# Animations
	if velocity.x < 0:
		$LimboBodyAnim.animation = "walk_left"
		$LimboBodyAnim.flip_h = false
		$LimboArmAnim.animation = "walk_left"
		$LimboArmAnim.flip_h = false
	elif velocity.x > 0:
		$LimboBodyAnim.animation = "walk_left" # right
		$LimboBodyAnim.flip_h = true
		$LimboArmAnim.animation = "walk_left"
		$LimboArmAnim.flip_h = true
	elif velocity.y < 0:
		$LimboBodyAnim.animation = "walk_up"
		$LimboBodyAnim.flip_h = false
		$LimboArmAnim.animation = "walk_up"
		$LimboArmAnim.flip_h = false
	elif velocity.y > 0:
		$LimboBodyAnim.animation = "walk_down"
		$LimboBodyAnim.flip_h = false
		$LimboArmAnim.animation = "walk_down"
		$LimboArmAnim.flip_h = false

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
