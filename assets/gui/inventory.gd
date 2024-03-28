extends Node2D

var save = []
var inv = []

func _process(_delta):
	inv = Glova.g_inv()
	if inv != save:
		print("test")
		var temp = TextureRect.new()
		temp.texture = load("res://assets/loot/items/" + str(inv[inv.size()-1]) + ".png")
		temp.modulate = Color(1, 1, 1, 0.5)
		temp.stretch_mode = 2
		print(str(inv[inv.size()-1]))
		$inv_con.add_child(temp)
		save = inv
