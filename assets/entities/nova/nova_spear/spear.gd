extends StaticBody2D

var nam = "spear"
var damage = 25
var dir
var attack = 1
var hits = []
var level = Glova.level

func _ready():
	$Timer.wait_time = $Timer.wait_time / attack
	$Timer.start()

func _process(_delta):
	if level != Glova.level:
		queue_free()
	
	for area in $spearhit.get_overlapping_areas():
		if area not in hits:
			hits.append(area)
			area.hit(damage,nam,dir)

func _on_timer_timeout():
	queue_free()
