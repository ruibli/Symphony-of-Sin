extends StaticBody2D

var door_closed = load("res://assets/map/manor/manor_door.png")
var door_open = load("res://assets/map/manor/manor_door_open.png")
var type

func _ready():
	if Glova.g_level() == 1: # level 1 manor assets
		door_closed = load("res://assets/map/manor/manor_door.png")
		door_open = load("res://assets/map/manor/manor_door_open.png")

func _process(_delta):
	if Glova.g_enemies() > 0:
		$door.texture = door_closed
		set_collision_layer_value(1,true)
	else:
		$door.texture = door_open
		set_collision_layer_value(1,false)

func _on_door_hit_area_entered(area):
	area.boop(type)
