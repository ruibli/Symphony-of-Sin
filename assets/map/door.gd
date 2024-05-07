extends StaticBody2D

var dir
var id
var special = false
var level
var type = "enemy"
var state = "open"

func _ready():
	
	if Glova.g_level() == 1: # level 1 manor assets
		level = "manor"

func _process(_delta):
	if Glova.g_id([0]) == [-1]:
		pass
	else:
		var ids = Glova.g_doors([0])
		
		for i in ids:
			if id == i:
				special = true
			if dir == "up" and id.y == i.y - 1 and id.x == i.x:
				special = true
			if dir == "down" and id.y == i.y + 1 and id.x == i.x:
				special = true
			if dir == "left" and id.x == i.x - 1 and id.y == i.y:
				special = true
			if dir == "right" and id.x == i.x + 1 and id.y == i.y:
				special = true
		
		if special:
			if id == ids[0]:
				type = "boss"
			if id == ids[1]:
				type = "shop"
			if id == ids[2]:
				type = "lore"
	
	if Glova.g_enemies() > 0:
		state = "closed"
		set_collision_layer_value(1,true)
	else:
		state = "open"
		set_collision_layer_value(1,false)
	
	$door.texture = load("res://assets/map/"+level+"/"+level+"_"+type+"_door_"+state+".png")

func _on_door_hit_area_entered(area):
	if Glova.g_enemies() == 0:
		area.boop(dir)
