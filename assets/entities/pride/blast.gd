extends RayCast2D

var damage = 40
var dir
var attack = 1

func _ready():
	$blast.hide()
	$Timer.wait_time = $Timer.wait_time / attack
	$Timer2.wait_time = $Timer2.wait_time / attack
	$Timer.start()
	$Timer2.start()

func _process(_delta):
	if is_colliding:
		var cast = to_local(get_collision_point())
		$blast.points[1] = Vector2(0,cast.y-6)
		$blast2.points[1] = Vector2(0,cast.y-6)
	else:
		$blast.points[1] = Vector2(0,320)
		$blast2.points[1] = Vector2(0,320)

func _on_timer_timeout():
	queue_free()

func _on_blasthit_area_entered(area):
	area.hit(damage,name,dir)

func _on_timer_2_timeout():
	$blasthit.set_collision_mask_value(2,true)
	$blast.show()
