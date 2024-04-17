extends Control

func _ready():
	$VBoxContainer/start.grab_focus()

func _on_start_pressed():
	get_tree().change_scene_to_file("res://sos.tscn")

func _on_options_pressed():
	get_tree().change_scene_to_file("res://assets/gui/options.tscn")

func _on_quit_pressed():
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
