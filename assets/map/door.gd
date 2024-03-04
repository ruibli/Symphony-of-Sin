extends StaticBody2D

func _ready():
	if Glova.get_level() == 1: # level 1 manor assets
		$door.texture = load("res://assets/map/manor/manor_door.png")

func _process(_delta):
	if Glova.get_enemies() > 0:
		set_collision_layer_value(1,true)
	else:
		set_collision_layer_value(1,false)