extends CharacterBody2D

var speed = 150
var damage = 10
var dir
var wait = false
var rotat = 0

func _ready():
	$Timer.start()
	$Timer2.start()
	if velocity.x < 0:
		rotat = 270
	elif velocity.x > 0:
		rotat = 90
	elif velocity.y < 0:
		rotat = 180

func _process(_delta):
	if not wait:
			await get_tree().create_timer(0.05).timeout
			wait = true
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	move_and_slide()
	
	for index in get_slide_collision_count():
		change()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_roomdetector_area_entered(area: Area2D) -> void:
	if area.get_name() == 'CameraArea' and wait == true:
		queue_free()

func _on_timer_timeout():
	queue_free()

func _on_molotovhit_area_entered(area):
	area.hit(damage,name,dir)
	change()

func _on_timer_2_timeout():
	change()

func _on_molotovhit_2_area_entered(area):
	area.hit(damage,name,dir)

func change():
	$MolotovCollision/Molotov.texture = load("res://assets/entities/nova/nova_molotov/molotov_pool.png")
	$MolotovCollision/Molotov.rotation_degrees = rotat
	velocity = Vector2(0,0)
	$molotovhit.set_collision_mask_value(3,false)
	$molotovhit2.set_collision_mask_value(3,true)
