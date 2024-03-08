extends StaticBody2D

var type = "enemy"
var state = 1 # 1 = not on screen, 2 = on screen waiting for no enemies, 3 = spawned award 
var cost = [0, 0, 0, 0, 0, 0]
var temp
var item
var nam
var stats

func _ready():
	$pedestal.visible = false
	$item.visible = false
	$item.position = $pedestal.position + Vector2(0, -7)
	
	if type == "set":
		pass
		
	elif type == "enemy":
		item = randi_range(1,10)
		if item <= 4:
			item = "coin"
			$item.texture = load("res://assets/loot/generic/coin.png")
			stats = [0, 0, 0, 0, 0, 1]
		elif item <= 7:
			item = "potion"
			$item.texture = load("res://assets/loot/generic/potion.png")
			stats = [25, 0, 0, 0, 0, 0]
		elif item <= 9:
			item = "item"
			random_item()
		elif item <=10:
			item = "weapon"
			random_weapon()
			
	elif type == "lore":
		item = randi_range(1,3)
		if item <= 2:
			item = "item"
			random_item()
		elif item <=3:
			item = "weapon"
			random_weapon()
			
	elif type == "boss":
		item = "weapon"
		random_weapon()
	
	elif type == "shop":
		item = randi_range(1,3)
		if item <= 2:
			item = "item"
			cost = [0, 0, 0, 0, 0, -5]
			random_item()
		elif item <=3:
			item = "weapon"
			cost = [0, 0, 0, 0, 0, -10]
			random_weapon()		
	
func random_item():
	var item_pool = Glova.g_item_pool()
	if len(item_pool) == 0:
		breakfast()
	else:
		nam = randi_range(0, len(item_pool)-1) # get lengths
		nam = item_pool[nam]
		Glova.g_item_pool(nam)
		
		if nam == "breakfast":
			stats = [25, 25, 0, 0, 0, 0]

func random_weapon():
	var weapon_pool = Glova.g_weapon_pool()
	if len(weapon_pool) == 0:
		breakfast()
	else:
		nam = randi_range(0, len(weapon_pool)-1) # get lengths
		nam = weapon_pool[nam]
		Glova.g_weapon_pool(name)
		
		#if nam == "breakfast":
		#	stats = [25, 25, 0, 0, 0, 0]

func breakfast():
	item = "item"
	nam = "Breakfast"
	$item.texture = load("res://assets/loot/items/breakfast.png")
	stats = [25, 25, 0, 0, 0, 0]
	
	if type == "shop":
		cost = [0, 0, 0, 0, 0, -5]

func _process(_delta):
	if state == 2 and Glova.g_enemies() > 0:
		$Timer.start()

func _on_visible_on_screen_notifier_2d_screen_entered():
	if state == 1:
		$Timer.start()
		state = 2

func _on_timer_timeout():
	$pedestal.visible = true
	$item.visible = true
	state = 3

func _on_pedestal_area_area_entered(_area):
	if state == 3:
		if type == "shop" and Glova.g_stats()[5] >= abs(cost[5]) or type != "shop":
			if item == "coin" or item == "potion":
				pass
			elif item == "item":
				Glova.g_inv(nam)
			elif item == "weapon":
				Glova.g_hotbar(nam)
			Glova.g_stats(stats)
			Glova.g_stats(cost)
			queue_free()
