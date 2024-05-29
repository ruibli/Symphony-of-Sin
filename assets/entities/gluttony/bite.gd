extends StaticBody2D

var damage = 15

func _ready():
	$Timer.start()

func _on_timer_timeout():
	queue_free()

func _on_bitethit_area_entered(area):
	area.hit(damage,global_position,false)
