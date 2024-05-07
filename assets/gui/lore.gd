extends Control

func _process(_delta):
	var lore = Glova.g_lore(-1)
	if  lore >= 16:
		modulate = Color(1,1,1,0)
	else:
		modulate = Color(1,1,1,1-(lore/16))
	
	var level = Glova.g_level(0)
	
	if level == 1:
		$lore.text = "level 1"
