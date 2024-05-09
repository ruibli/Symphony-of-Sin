extends StaticBody2D

var dir
var id
var level
var type = "enemy"
var state = "open"

func _ready():
	if Glova.g_level() == 1: # level 1 manor assets
		level = "manor"

func _process(_delta):
	if typeof(Glova.g_id([0])) == TYPE_ARRAY:
		var ids = Glova.g_doors([0])
		for i in ids:
			if id == i:
				if i == ids[0]:
					type = "boss"
				if i == ids[1]:
					type = "shop"
				if i == ids[2]:
					type = "lore"
			if dir == "up" and id.y == i.y + 1 and id.x == i.x:
				if i == ids[0]:
					type = "boss"
				if i == ids[1]:
					type = "shop"
				if i == ids[2]:
					type = "lore"
			if dir == "down" and id.y == i.y - 1 and id.x == i.x:
				if i == ids[0]:
					type = "boss"
				if i == ids[1]:
					type = "shop"
				if i == ids[2]:
					type = "lore"
			if dir == "left" and id.x == i.x + 1 and id.y == i.y:
				if i == ids[0]:
					type = "boss"
				if i == ids[1]:
					type = "shop"
				if i == ids[2]:
					type = "lore"
			if dir == "right" and id.x == i.x - 1 and id.y == i.y:
				if i == ids[0]:
					type = "boss"
				if i == ids[1]:
					type = "shop"
				if i == ids[2]:
					type = "lore"
	
	if Glova.g_enemies() > 0:
		state = "closed"
		set_collision_layer_value(1,true)
		$DoorHit.set_collision_layer_value(1,false)
	else:
		state = "open"
		set_collision_layer_value(1,false)
		$DoorHit.set_collision_layer_value(1,true)
	
	$door.texture = load("res://assets/map/"+level+"/"+level+"_"+type+"_door_"+state+".png")
	
	for area in $DoorHit.get_overlapping_areas():
		if Glova.g_enemies() == 0:
			area.boop(dir)
