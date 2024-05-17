extends StaticBody2D

func _process(_delta):
	Glova.lore = global_position.distance_to(Glova.pos)
