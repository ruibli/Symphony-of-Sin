extends CharacterBody2D

var nam = "crossbow"
var wait = false
var speed = 150
var damage = 20
var dir
var hits = []
var level = Glova.level

func _ready():
	$Timer.start()
	

func _process(_delta):
	if level != Glova.level:
		queue_free()
	
	if not wait:
			await get_tree().create_timer(0.05).timeout
			wait = true
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	move_and_slide()
	
	for area in $crossbowhit.get_overlapping_areas():
		if area not in hits:
			hits.append(area)
			area.hit(damage,nam,dir)
			queue_free()
	
	for index in get_slide_collision_count():
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_roomdetector_area_entered(area: Area2D) -> void:
	if area.get_name() == 'CameraArea' and wait == true:
		queue_free()

func _on_timer_timeout():
	queue_free()
