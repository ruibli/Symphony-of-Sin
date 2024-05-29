extends StaticBody2D

var damage = 20
var gain = true

func _ready():
	$Timer.start()

func _on_timer_timeout():
	queue_free()

func _on_gauntletshit_area_entered(area):
	area.hit(damage,global_position,gain)
