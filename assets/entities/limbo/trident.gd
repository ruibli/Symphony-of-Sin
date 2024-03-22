extends StaticBody2D

var damage = 25

func _ready():
	$Timer.start()

func _on_timer_timeout():
	queue_free()

func _on_tridenthit_area_entered(area):
	area.hit(damage)
