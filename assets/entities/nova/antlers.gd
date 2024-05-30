extends RayCast2D

var velocity = Vector2(0,0)
var damage = 100
var dir

func _ready():
	$Antlers.hide()
	velocity = Vector2(0,0)	
	$Timer.start()

func _process(_delta):
	if is_colliding:
		var cast = to_local(get_collision_point())
		$Antlers.points[1] = Vector2(0,cast.y-6)
	else:
		$Antlers.points[1] = Vector2(0,320)
		
	$antlershit.set_collision_mask_value(3,true)
	$Antlers.show()

func _on_timer_timeout():
	queue_free()

func _on_antletshit_area_entered(area):
	area.hit(damage,global_position,name,dir)
