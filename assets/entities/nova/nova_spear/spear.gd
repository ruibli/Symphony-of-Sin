extends StaticBody2D

var nam = "spear"
var damage = 25
var dir
var attack = 1

func _ready():
	$Timer.wait_time = $Timer.wait_time / attack
	$Timer.start()

func _process(_delta):
	for area in $spearhit.get_overlapping_areas():
		area.hit(damage,nam,dir)

func _on_timer_timeout():
	queue_free()
