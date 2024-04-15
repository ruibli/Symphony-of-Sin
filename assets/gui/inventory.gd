extends Node2D

var save = []
var inv = []

func _process(_delta):
	inv = Glova.g_inv()
	
	if save != inv:
		var temp = TextureRect.new()
		temp.texture = load("res://assets/loot/items/" + str(inv[inv.size()-1]) + ".png")
		temp.stretch_mode = 2
		$inv_con.add_child(temp)
		save.append(str(inv[inv.size()-1]))
