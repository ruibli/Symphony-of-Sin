extends StaticBody2D

var type = "enemy"
var state = 1 # 1 = not on screen, 2 = on screen waiting for no enemies, 3 = spawned award 
var temp
var item
var nam
var stats

func _ready():
	$pedestal.visible = false
	$item.visible = false
	$item.position = $pedestal.position + Vector2(0, -8)
	
	if type == "set":
		pass
	elif type == "enemy":
		item = randi_range(1,10)
		if item <= 4:
			item = "coin"
			$item.texture = load("res://assets/loot/generic/coin.png")
			stats = [0, 0, 0, 0, 0, 1]
		elif item <= 8:
			item = "potion"
			$item.texture = load("res://assets/loot/generic/potion.png")
			stats = [25, 0, 0, 0, 0, 0]
		else:
			random_item()
			
	
func random_item():
	# decide item or weapon reward
	# if length of pool = 0, breakfast
	item = randi_range(1,10) # get lengths
	breakfast()

func breakfast():
	item = "item"
	nam = "Breakfast"
	$item.texture = load("res://assets/loot/items/breakfast.png")
	stats = [25, 25, 0, 0, 0, 0]

func _process(_delta):
	if state == 2 and Glova.get_enemies() > 0:
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
			if item == "coin" or item == "potion":
				pass
			elif item == "item":
				pass #Glova.set inv,
			elif item == "weapon":
				pass # glova. set hotbar
			Glova.g_stats("set", stats)
			queue_free()
