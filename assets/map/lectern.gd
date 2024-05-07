extends StaticBody2D

func _process(_delta):
	Glova.g_lore(global_position.distance_to(Glova.g_pos()))
