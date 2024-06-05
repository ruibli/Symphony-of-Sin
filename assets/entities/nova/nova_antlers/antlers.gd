extends Node2D

var nam = "antlers"
var damage = 50
var dir
var attack = 1

func _ready():
	$antlers.hide()
	$antlers2.hide()
	$Timer.wait_time = $Timer.wait_time / attack
	$Timer2.wait_time = $Timer2.wait_time / attack
	$Timer.start()
	$Timer2.start()

func _process(_delta):
	if $RayDown.is_colliding or $RayDown2.is_colliding:
		var cast = to_local($RayDown.get_collision_point()).y-6
		var cast2 = to_local($RayDown2.get_collision_point()).y-6
		if cast <= cast2:
			$antlers.points[1] = Vector2(0,cast)
			$antlers2.points[1] = Vector2(0,cast)
			$antlershit/AntlersHit.shape.size.y = cast+12
			$antlershit/AntlersHit.position.y = (cast-3)/2
		else:
			$antlers.points[1] = Vector2(0,cast2)
			$antlers2.points[1] = Vector2(0,cast2)
			$antlershit/AntlersHit.shape.size.y = cast2+12
			$antlershit/AntlersHit.position.y = (cast2-3)/2
	else:
		$antlers.points[1] = Vector2(0,320)
		$antlers2.points[1] = Vector2(0,320)
		$antlershit/AntlersHit.shape.size.y = 332
		$antlershit/AntlersHit.position.y = 160
		
	for area in $antlershit.get_overlapping_areas():
		area.hit(damage,nam,dir)
	$antlers2.show()
	
func _on_timer_timeout():
	queue_free()

func _on_timer_2_timeout():
	$antlershit.set_collision_mask_value(3,true)
	$antlers.show()
