extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if Glova.g_level() == 1: # level 1 manor assets
		$blocker.texture = load("res://assets/map/manor/manor_blocker.png")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_visible_on_screen_notifier_2d_screen_entered():
	set_collision_layer_value(6, true)

func _on_visible_on_screen_notifier_2d_screen_exited():
	set_collision_layer_value(6, false)
