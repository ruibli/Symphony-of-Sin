extends RayCast2D

var velocity = Vector2(0,0)
var damage = 100
var wait = false

func _ready():
	$Antlers.hide()
	velocity = Vector2(0,0)	
	$Timer.start()
	$Timer2.start()

func _process(_delta):
	if not wait:
		await get_tree().create_timer(0.05).timeout
		wait = true

func _on_timer_timeout():
	queue_free()

func _on_antletshit_area_entered(area):
	area.hit(damage,global_position)

func _on_timer_2_timeout():
	if is_colliding:
		var cast  = to_local(get_collision_point())
		if rotation_degrees == 90 or rotation_degrees == 270:
			$Antlers.points[1].x = cast.x
		else:
			$Antlers.points[1].y = cast.y
		
		$antlershit.set_collision_mask_value(3,true)
		$Antlers.show()
