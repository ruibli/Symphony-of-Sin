extends StaticBody2D

@export var blocker_scene: PackedScene
var blocker
@export var limbo_scene: PackedScene
var limbo

var type = "enemy"
var level = 1
var layout

var count
var enemy
var temp
var locations
var location

func _ready():
	if level == 1: # level 1 castle assets
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
	
	if type == "enemy":	
		layout = randi_range(0,1)
		if layout == 1: # diagonals
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
			
			count = randi_range(level,level+2)
			while count > 0:
				enemy = randi_range(1,1)
				if enemy == 1:
					temp = limbo_scene.instantiate()
				
				locations = [1,2,3,4,5,6,7,8]
				location = locations[randi() % locations.size()]
				if location == 1:
					temp.position = Vector2(64,64)
					# remove location from locations. drop or whatever
				add_child(temp)
			
		elif layout == 2:
			pass
		else: # blank
			pass

func _process(_delta):
	pass
