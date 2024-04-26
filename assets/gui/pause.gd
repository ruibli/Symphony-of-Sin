extends Control

var can_pause = true
var level = 1
var mod = 0

var time =  0.0
var hours = 0
var minutes = 0
var seconds = 0

var code = ["ui_down","ui_up","ui_left","ui_down","ui_up","ui_right","ui_down","ui_up"]
var index = 0

func _ready():
	$fade/black/AnimationPlayer.play("clear")
	hide()

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		if can_pause:
			if get_tree().paused == true: # unpause
				hide()
				get_tree().paused = false
				can_pause = false
				$pause_timer.start()
			else: # pause
				show()
				get_tree().paused = true
				$continue.grab_focus()
				index = 0
	
	if get_tree().paused == false:
		time += delta
		hide()
	
	level = str(Glova.g_level(0))
	mod = str(Glova.g_mod(0))
	hours = int(fmod(time, 216000)/3600)
	minutes = int(fmod(time, 3600)/60)
	seconds = int(fmod(time, 60))

	if hours < 10:
		hours = "0" + str(hours) + ":"
	else:
		hours = str(hours) + ":"
		
	if minutes < 10:
		minutes = "0" + str(minutes) + ":"
	else:
		minutes = str(minutes) + ":"
		
	if seconds < 10:
		seconds = "0" + str(seconds)
	else:
		seconds = str(seconds)
	
	$VBoxContainer/level_con/level.text = level
	$VBoxContainer/mod_con/mod.text = mod
	$VBoxContainer/time_con/HBoxContainer/hours.text = hours
	$VBoxContainer/time_con/HBoxContainer/minutes.text = minutes
	$VBoxContainer/time_con/HBoxContainer/seconds.text = seconds

	print(index)
	if Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right"):
		if Input.is_action_just_pressed(code[index], true) and get_tree().paused == true:
			index += 1
			if index == code.size():
				$debug.show()
				index = 0
		else:
			index = 0

func _on_timer_timeout():
	can_pause = true

func _on_main_pressed():
	$fade/black/AnimationPlayer.play("black")
	await get_tree().create_timer(0.25).timeout
	get_tree().paused = false
	get_tree().change_scene_to_file("res://assets/gui/main.tscn")

func _on_main_focus_entered():
	$main.modulate = Color(190/255.0,118/255.0,253/255.0, 1)

func _on_main_focus_exited():
	$main.modulate = Color(1,1,1,1)

func _on_continue_pressed():
	if can_pause:
		if get_tree().paused == true: # unpause
			hide()
			get_tree().paused = false
			can_pause = false
			$pause_timer.start()

func _on_continue_focus_entered():
	$continue.modulate = Color(190/255.0,118/255.0,253/255.0, 1)

func _on_continue_focus_exited():
	$continue.modulate = Color(1,1,1,1)
