extends RigidBody2D

var type = "enemy"
var state = 1
var temp
var item
var stats

func _ready():
	$pedestal.visible = false
	$item.visible = false
	$item.position = $pedestal.position + Vector2(0, -8)
	
	if type == "enemy":
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
	item = randi_range(1,10)
	breakfast()

func breakfast():
	item = "breakfast"
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

func _on_body_entered(_body:Node):
	if state == 3:
		if item == "coin" or item == "potion":
			pass
		else:
			pass
			#Glova.set inv,
		Glova.set_stats(stats)
		queue_free()
