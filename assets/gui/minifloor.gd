extends Sprite2D

var temp

var type = "enemy"
var right = true
var left = true
var down = true
var up = true

func _ready():
	if type == "boss":
		texture = load("res://assets/gui/minimap/miniboss.png")
	elif type == "shop":
		texture = load("res://assets/gui/minimap/minishop.png")
	elif type == "spawn":
		texture = load("res://assets/gui/minimap/minispawn.png")
	elif type == "lore":
		texture = load("res://assets/gui/minimap/minilore.png")
	else:
		texture = load("res://assets/gui/minimap/minienemy.png")
		
	if !right:
		temp = Sprite2D.new()
		temp.texture = load("res://assets/gui/minimap/minifill.png")
		temp.position = Vector2(3, 0)
		temp.rotation_degrees = 90
		add_child(temp)
	if !left:
		temp = Sprite2D.new()
		temp.texture = load("res://assets/gui/minimap/minifill.png")
		temp.position = Vector2(-3, 0)
		temp.rotation_degrees = 270
		add_child(temp)
	if !down:
		temp = Sprite2D.new()
		temp.texture = load("res://assets/gui/minimap/minifill.png")
		temp.position = Vector2(0, 3)
		temp.rotation_degrees = 180
		add_child(temp)
	if !up:
		temp = Sprite2D.new()
		temp.texture = load("res://assets/gui/minimap/minifill.png")
		temp.position = Vector2(0, -3)
		temp.rotation_degrees = 0
		add_child(temp)
