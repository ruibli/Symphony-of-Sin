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
		$sins/AnimationPlayer.speed_scale = 1 * sins
		$sins/AnimationPlayer.play("pulse")
	if sins < 0:
		Glova.sins = 0
	if sins > 1:
		Glova.sins = 1
		
	if Input.is_action_pressed("attack_up") or Input.is_action_pressed("attack_down") or Input.is_action_pressed("attack_left") or Input.is_action_pressed("attack_right"):
		if Glova.current in Glova.ranged and Glova.sins <= 0:
			$sins/AnimationPlayer.play("flash")
			
	if health/health_max != save:
		var tween = get_tree().create_tween()
		tween.tween_property($iframes, "value", health/health_max, 1)
		save = health/health_max
