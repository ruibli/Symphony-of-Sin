extends RigidBody2D

func _ready():
	if Glova.get_level() == 1: # level 1 manor assets
		$door.texture = load("res://assets/map/manor/manor_door.png")
		$door_open.texture = load("res://assets/map/manor/manor_door_open.png")

func _process(_delta):
	if Glova.get_enemies() > 0:
		$door.visible = true
		$door_open.visible = false
		set_collision_layer_value(1,true)
	else:
		$door.visible = false
		$door_open.visible = true
		set_collision_layer_value(1,false)
