extends StaticBody2D

var level = "manor"

func _ready():
	if Glova.level == 1: # level 1 manor assets
		level = "manor"

func _process(_delta):
	$blocker.play(level)

func _on_visible_on_screen_notifier_2d_screen_entered():
	set_collision_layer_value(6, true)

func _on_visible_on_screen_notifier_2d_screen_exited():
	set_collision_layer_value(6, false)
