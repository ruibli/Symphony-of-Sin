extends CharacterBody2D
var wait = false
var speed = 150
var damage = 10
var dir


func _ready():
	$Timer.start()
	

func _process(_delta):
	if not wait:
			await get_tree().create_timer(0.05).timeout
			wait = true
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	move_and_slide()
	
	for index in get_slide_collision_count():
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_roomdetector_area_entered(area: Area2D) -> void:
	if area.get_name() == 'CameraArea' and wait == true:
		queue_free()

func _on_crossbowhit_area_entered(area):
	area.hit(damage,name,dir)
	queue_free()

func _on_timer_timeout():
	queue_free()
