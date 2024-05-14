extends StaticBody2D

var state = 1 # 1 = not on screen, 2 = on screen waiting for no enemies, 3 = spawned award 
var rewarded = false

var type = "enemy"
var nam
var cost = [0, 0, 0, 0, 0, 0]

var temp
var item
var stats

func _ready():
	$pedestal.visible = false
	$item.visible = false
	$cost.visible = false
	$item.position = $pedestal.position + Vector2(0, -7)
	
func reward():
	rewarded = true
	if type == "debug":
		if item == "coin":
			$item.texture = load("res://assets/loot/generic/coin.png")
			stats = [0, 0, 0, 0, 0, 1]
		elif item == "potion":	
			$item.texture = load("res://assets/loot/generic/potion.png")
			stats = [25, 0, 0, 0, 0, 0]
		elif item == "item":
			random_item()
		elif item == "weapon":	
			random_weapon()
	elif type == "enemy":
		item = randi_range(1,10)
		if item <= 5:
			item = "coin"
			$item.texture = load("res://assets/loot/generic/coin.png")
			stats = [0, 0, 0, 0, 0, 1]
		elif item <= 9:
			item = "potion"
			$item.texture = load("res://assets/loot/generic/potion.png")
			stats = [25, 0, 0, 0, 0, 0]
		elif item <= 10:
			item = "item"
			random_item()
			
	elif type == "lore":
		item = randi_range(1,5)
		if item <= 4:
			item = "item"
			random_item()
		elif item <=5:
			item = "weapon"
			random_weapon()
			
	elif type == "boss":
		item = "weapon"
		random_weapon()
	
	elif type == "shop":
		item = randi_range(1,5)
		if item <= 4:
			item = "item"
			cost = [0, 0, 0, 0, 0, -5]
			$cost.text = "5G"
			random_item()
		elif item <=5:
			item = "potion"
			cost = [0, 0, 0, 0, 0, -2]
			$cost.text = "2G"
			$item.texture = load("res://assets/loot/generic/potion.png")
			stats = [25, 0, 0, 0, 0, 0]
	
func random_item():
	var item_pool = Glova.g_item_pool("0")
	if len(item_pool) == 0 or item_pool.is_empty():
		breakfast()
	else:
		if type != "debug":
			nam = randi_range(0, len(item_pool)-1) # get lengths
			nam = item_pool[nam]
			Glova.g_item_pool(nam)
		
		$item.texture = load("res://assets/loot/items/"+nam+".png")
		
		if nam == "breakfast":
			stats = [25, 25, 0, 0, 0, 0]
		elif nam == "platinum":
			stats = [0, 0, 0, 0, 0, 5]
		elif nam == "glass":
			stats = [-50, -50, 0, 0.5, 0, 0]
		elif nam == "feather":
			stats = [-25, -25, 0.25, -0.25, 0.25, 0]
		elif nam == "vest":
			stats = [50, 50, -0.5, 0, 0, 0]
		elif nam == "scale":
			var ave = (Glova.g_stats()[2] + Glova.g_stats()[3] + Glova.g_stats()[4])/3
			stats = [0, 0, ave-Glova.g_stats()[2], ave-Glova.g_stats()[3], ave-Glova.g_stats()[4], 0]
		elif nam == "colon":
			stats = [25, 25, 0.25, 0.25, 0.25, 1]
		elif nam == "boots":
			stats = [0, 0, 0.25, 0, 0, 0]

func random_weapon():
	var weapon_pool = Glova.g_weapon_pool("0")
	if len(weapon_pool) == 0 or weapon_pool.is_empty():
		breakfast()
	else:
		if type != "debug":
			nam = randi_range(0, len(weapon_pool)-1) # get lengths
			nam = weapon_pool[nam]
			Glova.g_weapon_pool(nam)
	
		$item.texture = load("res://assets/loot/weapons/"+nam+".png")

func breakfast():
	item = "item"
	nam = "breakfast"
	$item.texture = load("res://assets/loot/items/breakfast.png")
	stats = [25, 25, 0, 0, 0, 0]
	
	if type == "shop":
		cost = [0, 0, 0, 0, 0, -5]
		$cost.text = "5G"

func _process(_delta):
	if state == 2 and Glova.g_enemies() > 0 and type != "debug":
		$Timer.start()
	for _area in $PedestalArea.get_overlapping_areas():
		if state == 3:
			if type == "shop" and Glova.g_stats()[5] >= abs(cost[5]) or type != "shop":
				if (item == "potion" and Glova.g_stats()[1] != Glova.g_stats()[0]) or item != "potion":
					if item == "coin" or item == "potion":
						Glova.g_stats(stats)
					elif item == "item":
						Glova.g_inv(nam)
						Glova.g_stats(stats)
					elif item == "weapon":
						Glova.g_hotbar(nam)
					Glova.g_stats(cost)
					queue_free()

func _on_visible_on_screen_notifier_2d_screen_entered():
	$Timer.start()
	state = 2
	$pedestal.visible = false
	$item.visible = false
	$cost.visible = false

func _on_timer_timeout():	
	if !rewarded:
		reward()
	$pedestal.visible = true
	$item.visible = true
	$cost.visible = true
	state = 3

func _on_visible_on_screen_notifier_2d_screen_exited():
	state = 1
	$pedestal.visible = false
	$item.visible = false
	$cost.visible = false
