extends Node

var level = 1
var position
var enemies = 0

func set_level(l):
	level = l

func get_level():
	return level

func set_pos(p):
	position = p

func get_pos():
	return position

func change_enemies(s):
	enemies += s
	
func get_enemies():
	return enemies

func reset():
	level = 1
	enemies = 0
