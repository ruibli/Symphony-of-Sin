extends Node2D

var speed = 1
var power = 1 
var attack = 1
var gold = 0

func _process(_delta):
	$VBoxContainer/speed_con/speed_label.text = str(Glova.g_stats()[2])
	$VBoxContainer/power_con/power_label.text = str(Glova.g_stats()[3])
	$VBoxContainer/attack_con/attack_label.text = str(Glova.g_stats()[4])
	$VBoxContainer/gold_con/gold_label.text = str(Glova.g_stats()[5])
