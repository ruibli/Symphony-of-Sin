extends Node2D

var stats = [1,1,1,0]
var save = [1,1,1,0]

func _process(_delta):

	stats[0] = str("%04.2f" % Glova.stats[2])
	stats[1] = str("%04.2f" % Glova.stats[3])
	stats[2] = str("%04.2f" % Glova.stats[4])
	stats[3] = str(Glova.stats[5])
	
	$VBoxContainer/speed_con/speed_label.text = stats[0]
	$VBoxContainer/power_con/power_label.text = stats[1]
	$VBoxContainer/attack_con/attack_label.text = stats[2]
	$VBoxContainer/gold_con/gold_label.text = stats[3]
	
	if float(stats[0]) > save[0]:
		save[0] = float(stats[0])
		$VBoxContainer/speed_con/speed_label/AnimationPlayer.play("good")
	if float(stats[0]) < save[0]:
		save[0] = float(stats[0])
		$VBoxContainer/speed_con/speed_label/AnimationPlayer.play("bad")

	if float(stats[1]) > save[1]:
		save[1] = float(stats[1])
		$VBoxContainer/power_con/power_label/AnimationPlayer.play("good")
	if float(stats[1]) < save[1]:
		save[1] = float(stats[1])
		$VBoxContainer/power_con/power_label/AnimationPlayer.play("bad")
		
	if float(stats[2]) > save[2]:
		save[2] = float(stats[2])
		$VBoxContainer/attack_con/attack_label/AnimationPlayer.play("good")
	if float(stats[2]) < save[2]:
		save[2] = float(stats[2])
		$VBoxContainer/attack_con/attack_label/AnimationPlayer.play("bad")
	
	if float(stats[3]) > save[3]:
		save[3] = float(stats[3])
		$VBoxContainer/gold_con/gold_label/AnimationPlayer.play("good")
	if float(stats[3]) < save[3]:
		save[3] = float(stats[3])
		$VBoxContainer/gold_con/gold_label/AnimationPlayer.play("bad")
