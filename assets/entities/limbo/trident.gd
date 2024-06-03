extends StaticBody2D

var damage = 10	
var attack = 1
var dir

func _ready():
	$Timer.wait_time = $Timer.wait_time / attack
	$Timer.start()

func _on_timer_timeout():
	queue_free()

func _on_tridenthit_area_entered(area):
	area.hit(damage,name,dir)
