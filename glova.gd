extends Node

var i_pool_full = ["breakfast","platinum","glass","feather","vest","scale","colon","boots","syringe","helmet","steak","dumbbell","goldfish","debit","wildcard"]
var w_pool_full = ["spear","gauntlets","molotov","antlers"]
var ranged = ["crossbow","molotov","antlers"]
var last = 2
var	mins = [1, 1, 0.5, 0.5, 0.5, 0]

var pos = Vector2(0,0)
var cooldown = 0
var spawn_vars = [0,0]
var volume = 100
var remind = true
var lore

var sins
var level
var mod
var enemies
var stats

var inv
var hotbar
var current

var item_pool
var weapon_pool

var id = []
var doors = []

func new_game():
	sins =  float(0)
	level = 1
	mod = 0
	enemies = 0
	stats = [100, 100, 1, 1, 1, 0]
	# health, max, speed, power, attack, gold
	
	inv = []
	hotbar = ["axe", "crossbow", "empty", "empty", "empty", "empty", "empty"]
	current = "axe"
	
	item_pool = i_pool_full.duplicate()
	weapon_pool = w_pool_full.duplicate()
	
	id = [-1]
	doors = []
	
func new_floor():
	Glova.enemies = 0
	Glova.id = []
	Glova.doors = []

func change(s):
	for i in range(0,6):
		if stats[i] + s[i] < mins[i]:
			Glova.stats[i] = mins[i]
		else:
			stats[i] = stats[i] + s[i]
