extends Node2D

@export var mini_floor: PackedScene

var save = []
var ids = []

func _process(_delta):
	ids = Glova.g_ids([0])
	
	if ids[0][2] != "spawn":
		Glova.g_ids([])
		ids = []
	
	if ids != save:
		var id = ids[ids.size()-1]
		var temp = mini_floor.instantiate()
		temp.type = id[2]
		temp.position = Vector2(id[0],id[1]) * 8
		add_child(temp)
		save.append(id)
		print(id)
