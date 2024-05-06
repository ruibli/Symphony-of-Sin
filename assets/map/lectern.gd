extends StaticBody2D

func _process(_delta):
	var distance = global_position.distance_to(Glova.g_pos())
	
	if  distance <= 16:
		$lore.modulate = Color(1,1,1,0)
	else:
		$lore.modulate = Color(1,1,1,1-(distance/16))
