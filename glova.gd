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
var item_pool
var weapon_pool

func reset():
	level = 1
	mod = 0
	enemies = 0
	stats = [100, 100, 1, 1, 1, 0]
	# health, health_max, speed, power, attack, gold
	
	inv = []
	hotbar = ["crossbow", " ", " ", " ", " ", " ", " ", " "]
	item_pool = ["breakfast"]
	weapon_pool = []

func g_stats(s: Array = [0]):
	if s == [0]:
		return stats
	else:
		stats[0] = stats[0] + s[0]
		stats[1] = stats[1] + s[1]
		stats[2] = stats[2] + s[2]
		stats[3] = stats[3] + s[3]
		stats[4] = stats[4] + s[4]
		stats[5] = stats[5] + s[5]

func g_level(l: int = 0):
	if l == 0:
		return level
	else:
		level = l

func g_mod(m: int = 0):
	if m == 0:
		return mod
	else:
		mod = m

func g_pos(p: Vector2 = Vector2(9999, 9999)):
	if p == Vector2(9999, 9999):
		return pos
	else:
		pos = p

func g_enemies(e: int = 0):
	if enemies < 0:
		enemies = 0
	if e == 0:
		return enemies
	else:
		enemies += e

func g_inv(i: String = "0"):
	if i == "0":
		return inv
	else:
		inv.append(i)
		
func g_hotbar(h: String = "0"):
	if h == "0":
		return hotbar
	else:
		if hotbar[0] == "0":
			hotbar[0] = h
		elif hotbar[1] == "0":
			hotbar[1] = h
		elif hotbar[2] == "0":
			hotbar[2] = h
		elif hotbar[3] == "0":
			hotbar[3] = h
		elif hotbar[4] == "0":
			hotbar[4] = h
		elif hotbar[5] == "0":
			hotbar[5] = h
		elif hotbar[6] == "0":
			hotbar[6] = h
		else:
			hotbar[7] = h
			
func g_item_pool(i: String = "0"):
	if i == "0":
		return item_pool
	else:
		item_pool.remove_at(item_pool.find(i,0))

func g_weapon_pool(w: String = "0"):
	if w == "0":
		return weapon_pool
	else:
		weapon_pool.remove_at(weapon_pool.find(w,0))
