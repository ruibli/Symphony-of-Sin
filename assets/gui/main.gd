extends Control

func _ready():
	$VBoxContainer/start.grab_focus()
	$fade/black/AnimationPlayer.play("clear")

func _on_start_pressed():
	$fade/black/AnimationPlayer.play("black")
	await get_tree().create_timer(0.25).timeout
	get_tree().change_scene_to_file("res://sos.tscn")

func _on_options_pressed():
	$fade/black/AnimationPlayer.play("black")
	await get_tree().create_timer(0.25).timeout
	get_tree().change_scene_to_file("res://assets/gui/options.tscn")

func _on_quit_pressed():
	$fade/black/AnimationPlayer.play("black")
	await get_tree().create_timer(0.25).timeout
	get_tree().quit()

func _on_start_focus_entered():
	$VBoxContainer/start/start_label.modulate = Color(190/255.0,118/255.0,253/255.0, 1)

func _on_start_focus_exited():
	$VBoxContainer/start/start_label.modulate = Color(1,1,1,1)
	
func _on_options_focus_entered():
	$VBoxContainer/options/options_label.modulate = Color(190/255.0,118/255.0,253/255.0, 1)
	
func _on_options_focus_exited():
	$VBoxContainer/options/options_label.modulate = Color(1,1,1,1)

func _on_quit_focus_entered():
	$VBoxContainer/quit/quit_label.modulate = Color(190/255.0,118/255.0,253/255.0, 1)

func _on_quit_focus_exited():
	$VBoxContainer/quit/quit_label.modulate = Color(1,1,1,1)
