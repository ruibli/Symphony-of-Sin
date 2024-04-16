extends Control

func _ready():
	$VBoxContainer/start.grab_focus()

func _on_start_pressed():
	get_tree().change_scene_to_file("res://sos.tscn")

func _on_menu_pressed():
	pass # Replace with function body.

func _on_quit_pressed():
	get_tree().quit()
