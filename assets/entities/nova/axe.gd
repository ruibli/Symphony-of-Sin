extends StaticBody2D

var damage = 25
var dir
var attack = 1

func _ready():
	$Timer.wait_time = $Timer.wait_time / attack
	$Timer.start()

func _on_timer_timeout():
	queue_free()

func _on_axehit_area_exited(area):
	area.hit(damage,name,dir)
