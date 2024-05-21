extends StaticBody2D

var damage = 35

func _ready():
	$Timer.start()

func _on_timer_timeout():
	queue_free()

func _on_axehit_area_exited(area):
	area.hit(damage,global_position)
