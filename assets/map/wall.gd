extends StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	if Glova.g_level(get, 0) == 1: # level 1 manor assets
		$wall.texture = load("res://assets/map/manor/manor_wall.png")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
