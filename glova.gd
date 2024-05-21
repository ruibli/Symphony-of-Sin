extends Node

var pos = Vector2(0,0)
var item = [0]
var weapon = [1]

var sins = float(0)
var ranged = ["crossbow","molotov","antlers"]

var level = 1
var mod = 0
var enemies = 0
var stats = [100, 100, 1, 1, 1, 0]

var inv = []
var hotbar = ["gauntlets", "crossbow", "empty", "empty", "empty", "empty", "empty"]
var current = "gauntlets"
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
var type

func new_game():
	sins = 0
	level = 1
	mod = 0
	enemies = 0
	stats = [100, 100, 1, 1, 1, 0]
	# health, health_max, speed, power, attack, gold
	
	inv = []
	hotbar = ["gauntlets", "crossbow", "empty", "empty", "empty", "empty", "empty"]
	current = "gauntlets"
	
	item_pool = i_pool_full.duplicate()
	weapon_pool = w_pool_full.duplicate()
	
	id = [-1]
	doors = []
	
func new_floor():
	Glova.enemies = 0
	Glova.id = []
	Glova.doors = []

func change(s):
	stats[0] = stats[0] + s[0]
	stats[1] = stats[1] + s[1]
	stats[2] = stats[2] + s[2]
	stats[3] = stats[3] + s[3]
	stats[4] = stats[4] + s[4]
	stats[5] = stats[5] + s[5]
