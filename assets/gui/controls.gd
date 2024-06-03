extends Control

func _ready():
	$main.grab_focus()
	$fade/black/AnimationPlayer.play("clear")

func _on_main_pressed():
	$fade/black/AnimationPlayer.play("black")
	await get_tree().create_timer(0.25).timeout
	get_tree().change_scene_to_file("res://assets/gui/main.tscn")

func _on_main_focus_entered():
	$main.modulate = Color(190/255.0,118/255.0,253/255.0, 1)

func _on_main_focus_exited():
	$main.modulate = Color(1,1,1,1)
