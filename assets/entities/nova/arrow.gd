extends CharacterBody2D

var speed = 150
var damage = 20

func _process(_delta):
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	move_and_slide()
	
	for index in get_slide_collision_count():
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_arrow_hit_area_entered(area):
		area.hit(damage)
		queue_free()
