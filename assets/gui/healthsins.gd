extends Node2D

var health = 100
var health_max = 100
var save = 1
var sins = float(0)

func _process(_delta):
	health = Glova.stats[0]
	health_max = Glova.stats[1]
	sins = Glova.sins
	$health.value = float(health)/health_max
	$health/health_label.text = str(int(health)) + "/" +str(int(health_max))
	$sins.value = sins
	
	if sins > 0:
		Glova.sins = sins - 0.001
	if sins < 0:
		Glova.sins = 0
	if sins > 1:
		Glova.sins = 1
	
	if health/health_max != save:
		var tween = get_tree().create_tween()
		tween.tween_property($iframes, "value", health/health_max, 1)
		save = health/health_max
