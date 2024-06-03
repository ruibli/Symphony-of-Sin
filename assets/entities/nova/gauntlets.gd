extends StaticBody2D

var damage = 30
var dir
var attack = 1

func _ready():
	$Timer.wait_time = $Timer.wait_time / attack
	$Timer.start()

func _on_timer_timeout():
	queue_free()

func _on_gauntletshit_area_entered(area):
	area.hit(damage,name,dir)
