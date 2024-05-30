extends Node2D

var save = []

func _process(_delta):
	if save != Glova.inv:
		var temp = TextureRect.new()
		temp.texture = load("res://assets/loot/items/" + str(Glova.inv[Glova.inv.size()-1]) + ".png")
		temp.stretch_mode = 2
		$inv_con.add_child(temp)
		save = Glova.inv.duplicate()
