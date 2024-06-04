extends RayCast2D

var velocity = Vector2(0,0)
var damage = 40
var dir
var attack = 1

func _ready():
	$Antlers.hide()
	velocity = Vector2(0,0)	
	$Timer.wait_time = $Timer.wait_time / attack
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

func _on_area_entered(area):
	area.hit(damage,name,dir)
