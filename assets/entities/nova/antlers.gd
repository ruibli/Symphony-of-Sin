extends RayCast2D

var damage = 50
var dir
var attack = 1

func _ready():
	$antlers.hide()
	$Timer.wait_time = $Timer.wait_time / attack
	$Timer2.wait_time = $Timer2.wait_time / attack
	$Timer.start()
	$Timer2.start()

func _process(_delta):
	if is_colliding:
		var cast = to_local(get_collision_point())
		$antlers.points[1] = Vector2(0,cast.y-6)
		$antlers2.points[1] = Vector2(0,cast.y-6)
	else:
		$antlers.points[1] = Vector2(0,320)
		$antlers2.points[1] = Vector2(0,320)
		
func _on_timer_timeout():
	queue_free()

func _on_antletshit_area_entered(area):
	area.hit(damage,name,dir)

func _on_timer_2_timeout():
	$antlershit.set_collision_mask_value(3,true)
	$antlers.show()
