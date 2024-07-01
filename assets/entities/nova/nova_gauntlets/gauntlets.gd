extends StaticBody2D

var nam = "gauntlets"
var damage = 30
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
	
	for area in $gauntletshit.get_overlapping_areas():
		if area not in hits:
			hits.append(area)
			area.hit(damage,nam,dir)

func _on_timer_timeout():
	queue_free()
