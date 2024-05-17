extends Control

var tween

func _ready():
	$volume_slider.grab_focus()
	$volume_slider.value = Glova.volume
	$fade/black/AnimationPlayer.play("clear")

func _on_volume_slider_value_changed(value):
	$budget.modulate = Color(1,1,1,1)
	Glova.volume = value
	if tween:
		tween.stop()
	tween = get_tree().create_tween()
	tween.tween_property($budget, "modulate", Color(0, 0, 0, 0), 3)

func _on_main_pressed():
	$fade/black/AnimationPlayer.play("black")
	await get_tree().create_timer(0.25).timeout
	get_tree().change_scene_to_file("res://assets/gui/main.tscn")

func _on_volume_slider_focus_entered():
	$volume_slider.modulate = Color(190/255.0,118/255.0,253/255.0, 1)

func _on_volume_slider_focus_exited():
	$volume_slider.modulate = Color(1,1,1,1)

func _on_main_focus_entered():
	$main.modulate = Color(190/255.0,118/255.0,253/255.0, 1)

func _on_main_focus_exited():
	$main.modulate = Color(1,1,1,1)
