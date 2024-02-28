extends StaticBody2D

var type = "enemy"
var rooms = [0,1] #list to choose from
var layout
@export var blocker_scene: PackedScene
var blocker

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
		layout = rooms[randi() % rooms.size()]
		if layout == 1: #diagonals
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(32,32)
			add_child(blocker)
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(-32,32)
			add_child(blocker)
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(32,-32)
			add_child(blocker)
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(-32,-32)
			add_child(blocker)
			
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(96,96)
			add_child(blocker)
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(-96,96)
			add_child(blocker)
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(96,-96)
			add_child(blocker)
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(-96,-96)
			add_child(blocker)
			
			
			
		elif layout == 2:
			pass
		else:
			pass

func _process(_delta):
	pass
