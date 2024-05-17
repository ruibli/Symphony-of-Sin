extends StaticBody2D

func _ready():
	if Glova.level == 1: # level 1 manor assets
		$wall.texture = load("res://assets/map/manor/manor_wall.png")
