extends StaticBody2D

var type = "enemy"

func _ready():
	if type == "boss":
		$floor.texture = load("res://assets/levels/castle/castle_boss.png")
	elif type == "spawn":
		$floor.texture = load("res://assets/levels/castle/castle_spawn.png")
	elif type == "lore":
		$floor.texture = load("res://assets/levels/castle/castle_lore.png")
	elif type == "shop":
		$floor.texture = load("res://assets/levels/castle/castle_shop.png")
	else:
		$floor.texture = load("res://assets/levels/castle/castle_floor.png")

func _process(_delta):
	pass
