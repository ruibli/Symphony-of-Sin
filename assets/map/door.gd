extends StaticBody2D

var dir
var id
var level
var type = "enemy"
var state = "open"
var wait = true

func _ready():
	if Glova.level == 1: # level 1 manor assets
		level = "manor"

func _process(_delta):
	if typeof(Glova.id) == TYPE_ARRAY:
		for i in Glova.doors:
			if id == i:
				if i == Glova.doors[0]:
					type = "boss"
				if i == Glova.doors[1]:
					type = "shop"
				if i == Glova.doors[2]:
					type = "lore"
			if dir == "up" and id.y == i.y + 1 and id.x == i.x:
				if i == Glova.doors[0]:
					type = "boss"
				if i == Glova.doors[1]:
					type = "shop"
				if i == Glova.doors[2]:
					type = "lore"
			if dir == "down" and id.y == i.y - 1 and id.x == i.x:
				if i == Glova.doors[0]:
					type = "boss"
				if i == Glova.doors[1]:
					type = "shop"
				if i == Glova.doors[2]:
					type = "lore"
			if dir == "left" and id.x == i.x + 1 and id.y == i.y:
				if i == Glova.doors[0]:
					type = "boss"
				if i == Glova.doors[1]:
					type = "shop"
				if i == Glova.doors[2]:
					type = "lore"
			if dir == "right" and id.x == i.x - 1 and id.y == i.y:
				if i == Glova.doors[0]:
					type = "boss"
				if i == Glova.doors[1]:
					type = "shop"
				if i == Glova.doors[2]:
					type = "lore"
	
	if Glova.enemies > 0:
		wait = false
		state = "closed"
		set_collision_layer_value(1,true)
		$DoorHit.set_collision_layer_value(1,false)
	else:
		if !wait:
			await get_tree().create_timer(0.5).timeout
			wait = true
		state = "open"
		set_collision_layer_value(1,false)
		$DoorHit.set_collision_layer_value(1,true)
	
	$door.texture = load("res://assets/map/"+level+"/"+level+"_"+type+"_door_"+state+".png")
	
	for area in $DoorHit.get_overlapping_areas():
		if Glova.enemies == 0:
			area.boop(dir)
