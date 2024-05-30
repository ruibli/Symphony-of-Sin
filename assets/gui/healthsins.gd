extends Node2D

var save = 1
var sins = float(0)

func _process(_delta):
	$health.value = float(Glova.stats[0])/Glova.stats[1]
	$health/health_label.text = str(int(Glova.stats[0])) + "/" +str(int(Glova.stats[1]))
	$sins.value = Glova.sins
	
	if "painting" in Glova.inv:
		Glova.sins = 1
	if Glova.sins > 0:
		Glova.sins = Glova.sins - 0.002
		$sins/AnimationPlayer.speed_scale = 1 * Glova.sins
		$sins/AnimationPlayer.play("pulse")
	if Glova.sins < 0:
		Glova.sins = 0
	if Glova.sins > 1:
		Glova.sins = 1
		
	if Input.is_action_pressed("attack_up") or Input.is_action_pressed("attack_down") or Input.is_action_pressed("attack_left") or Input.is_action_pressed("attack_right"):
		if Glova.current in Glova.ranged and Glova.sins <= 0:
			$sins/AnimationPlayer.play("flash")
			
	if Glova.stats[0]/Glova.stats[1] != save:
		var tween = get_tree().create_tween()
		tween.tween_property($iframes, "value", Glova.stats[0]/Glova.stats[1], 1)
		save = Glova.stats[0]/Glova.stats[1]
