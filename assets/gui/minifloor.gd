extends Sprite2D

var temp

var type = "enemy"
var right = true
var left = true
var down = true
var up = true

func _ready():
	texture = load("res://assets/gui/minimap/minifloor_"+type+".png")
	
	temp = Sprite2D.new()
	temp.position = Vector2(6, 0)
	temp.rotation_degrees = 90
	if !right:
		temp.texture = load("res://assets/gui/minimap/minifill.png")
	else:
		temp.texture = load("res://assets/gui/minimap/minifill_"+type+".png")
	add_child(temp)
	
	temp = Sprite2D.new()
	temp.position = Vector2(-6, 0)
	temp.rotation_degrees = 270
	if !left:
		temp.texture = load("res://assets/gui/minimap/minifill.png")
	else:
		temp.texture = load("res://assets/gui/minimap/minifill_"+type+".png")	
	add_child(temp)
	
	temp = Sprite2D.new()
	temp.position = Vector2(0, 6)
	temp.rotation_degrees = 180
	if !down:
		temp.texture = load("res://assets/gui/minimap/minifill.png")
	else:
		temp.texture = load("res://assets/gui/minimap/minifill_"+type+".png")
	add_child(temp)
	
	temp = Sprite2D.new()
	temp.position = Vector2(0, -6)
	temp.rotation_degrees = 0
	if !up:
		temp.texture = load("res://assets/gui/minimap/minifill.png")
	else:
		temp.texture = load("res://assets/gui/minimap/minifill_"+type+".png")
	add_child(temp)
