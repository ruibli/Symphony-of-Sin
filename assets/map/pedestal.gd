extends Node

var type = "enemy"
var state = 1
var temp
var inv 
var item
var stats

func _ready():
	if type == "enemy":
		item = randi_range(1,3)
		if item <= 3:
			inv = "coin"

func random_item():
	item = randi_range(1,10)

func breakfast():
	inv = "item"
	item = "breakfast"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if state == 1:
		if Glova.get_enemies() == 0:
			state = 2
		else:
			$pedestal.visible = false
			# set_collision_layer_value(1,false)
	elif state == 2:
		$pedestal.visible = true
		# set_collision_layer_value(1,true)
		if inv == "coin":	
			temp = Sprite2D.new()
			temp.texture = load("res://assets/loot/generic/coin.png")
			temp.position = $pedestal.global_position + Vector2(0, -8)
			add_child(temp)
		state = 3
	else:
		pass
		# for index in get_collision_count():
			# queue_free()
