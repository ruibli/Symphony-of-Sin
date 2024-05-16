extends StaticBody2D

func _ready():
	if Glova.level == 1: # level 1 manor assets
		$blocker.texture = load("res://assets/map/manor/manor_blocker.png")

func _on_visible_on_screen_notifier_2d_screen_entered():
	set_collision_layer_value(6, true)

func _on_visible_on_screen_notifier_2d_screen_exited():
	set_collision_layer_value(6, false)
