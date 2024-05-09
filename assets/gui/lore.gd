extends Control

func _process(_delta):
	var lore = Glova.g_lore(-1)
	if  lore >= 32:
		modulate = Color(1,1,1,0)
	elif lore <=16:
		modulate = Color(1,1,1,1)
	else:
		modulate = Color(1,1,1,1-((lore-16)/16))
	
	var level = Glova.g_level(0)
	
	if level == 1:
		$lore.text = """You are in memories of your past life.
You were of nobility.
You were sent here to train.
You will learn the truth instead."""
