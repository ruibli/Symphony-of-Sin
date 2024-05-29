extends StaticBody2D

var damage = 25
var gain = true

func _ready():
	$Timer.start()

func _on_timer_timeout():
	queue_free()

func _on_spearhit_area_entered(area):
	area.hit(damage,global_position,gain)
