extends Node2D

var health = 100
var health_max = 100
var save = 1

func _process(_delta):
	health = Glova.g_stats()[0]
	health_max = Glova.g_stats()[1]
	$health.value = float(health)/health_max
	$health/health_label.text = str(int(health)) + "/" +str(int(health_max))
	
	if health/health_max != save:
		var tween = get_tree().create_tween()
		tween.tween_property($iframes, "value", health/health_max, 1)
		save = health/health_max
