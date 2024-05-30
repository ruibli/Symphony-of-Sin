extends StaticBody2D

var damage = 40
var dir

func _ready():
	$Timer.start()

func _on_timer_timeout():
	queue_free()

func _on_axehit_area_exited(area):
	area.hit(damage,global_position,name,dir)
