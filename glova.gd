extends Node

var level = 1
var position
var enemies = 0
var item = [0]
var weapon = [1]

# awareness, awareness_max, speed, power, attack, gold
var stats = [100, 100, 150, 1, 1, 0]
var awareness = 100
var awareness_max = 100
var speed = 150
var power = 1
var attack = 1
var gold = 0

func set_stats(s):
	stats[0] = stats[0] + s[0]
	stats[1] = stats[1] + s[1]
	stats[2] = stats[2] + s[2]
	stats[3] = stats[3] + s[3]
	stats[4] = stats[4] + s[4]
	stats[5] = stats[5] + s[5]

func get_stats():
	return stats

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
	stats = [100, 100, 150, 1, 1, 0]

func get_pool(g):
	if g == 1:
		return item
	elif g == 2:
		return weapon
