extends Node2D

var speed = 1
var power = 1 
var attack = 1
var gold = 0

func _process(_delta):
	speed = snapped(Glova.g_stats()[2], 0.01)
	power = snapped(Glova.g_stats()[3], 0.01)
	attack = snapped(Glova.g_stats()[4], 0.01)
	gold = str(snapped(Glova.g_stats()[5], 0.01))
	
	if speed - int(speed) == 0:
		speed = str(speed) + ".00"
	elif 10*speed - int(10*speed) == 0:
		speed = str(speed) + "0"
	else:
		speed = str(speed)
		
	if power - int(power) == 0:
		power = str(power) + ".00"
	elif 10*power - int(10*power) == 0:
		power = str(power) + "0"
	else:
		power = str(power)
	
	if attack - int(attack) == 0:
		attack = str(attack) + ".00"
	elif 10*attack - int(10*attack) == 0:
		attack = str(attack) + "0"
	else:
		attack = str(attack)
	
	$VBoxContainer/speed_con/speed_label.text = speed
	$VBoxContainer/power_con/power_label.text = power
	$VBoxContainer/attack_con/attack_label.text = attack
	$VBoxContainer/gold_con/gold_label.text = gold
