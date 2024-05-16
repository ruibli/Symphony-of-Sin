extends Node

var level = 1
var mod = 0
var pos = Vector2(0,0)
var enemies = 0
var item = [0]
var weapon = [1]

var stats

var inv
var hotbar
var current
var cooldown = 0

var i_pool_full = ["breakfast","platinum","glass","feather","vest","scale","colon","boots","syringe","helmet","steak","dumbbell","goldfish","debit","wildcard"]
var w_pool_full = ["spear","axe","gauntlets","molotov","antlers"]
var item_pool
var weapon_pool
var spawn_vars = [0,0]

var volume = 100
var id = []
var doors = []
var lore

func reset():
	level = 1
	mod = 0
	enemies = 0
	stats = [100, 100, 1, 1, 1, 0]
	# health, health_max, speed, power, attack, gold
	
	inv = []
	hotbar = ["crossbow", "empty", "empty", "empty", "empty", "empty", "empty"]
	current = "crossbow"
	
	item_pool = i_pool_full.duplicate()
	weapon_pool = w_pool_full.duplicate()
	
	id = [-1]
	doors = []
