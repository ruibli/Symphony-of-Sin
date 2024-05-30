extends Control

func _process(_delta):
	if Glova.lore >= 32:
		modulate = Color(1,1,1,0)
	elif Glova.lore <=16:
		modulate = Color(1,1,1,1)
	else:
		modulate = Color(1,1,1,1-((Glova.lore-16)/16))
	
	if Glova.level == 1:
		$lore.text = """You are in memories of your past life.
You were of nobility.
You were sent here to train.
You will learn the truth instead."""
