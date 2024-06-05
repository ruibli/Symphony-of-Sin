extends StaticBody2D

var nam = "greataxe"
var damage = 15
var attack = 1
var dir

func _ready():
	$Timer.wait_time = $Timer.wait_time / attack
	$Timer.start()

func _process(_delta):
	for area in $greataxehit.get_overlapping_areas():
		area.hit(damage,nam,dir)

func _on_timer_timeout():
	queue_free()
