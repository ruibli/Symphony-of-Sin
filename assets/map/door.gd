extends StaticBody2D

var door_closed = load("res://assets/map/manor/manor_door.png")
var door_open = load("res://assets/map/manor/manor_door_open.png")
var dir
var id

func _ready():
	
	if Glova.g_level() == 1: # level 1 manor assets
		door_closed = load("res://assets/map/manor/manor_door.png")
		door_open = load("res://assets/map/manor/manor_door_open.png")

func _process(_delta):
	var ids = Glova.g_doors([0])
	
	if id == ids[0]:
		$door.modulate = Color(1,0,0,1)
	if id == ids[1]:
		$door.modulate = Color(0,1,0,1)
	if id == ids[2]:
		$door.modulate = Color(1,0,1,1)
	
	if Glova.g_enemies() > 0:
		$door.texture = door_closed
		set_collision_layer_value(1,true)
	else:
		$door.texture = door_open
		set_collision_layer_value(1,false)

func _on_door_hit_area_entered(area):
	if Glova.g_enemies() == 0:
		area.boop(dir)
