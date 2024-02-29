extends StaticBody2D

@export var blocker_scene: PackedScene
var blocker
@export var limbo_scene: PackedScene
var limbo

var type = "enemy"
var level = Glova.get_level()
var temp

func _ready():
	if level == 1: # level 1 manor assets
		if type == "boss":
			$floor.texture = load("res://assets/levels/manor/manor_boss.png")
		elif type == "spawn":
			$floor.texture = load("res://assets/levels/manor/manor_spawn.png")
		elif type == "lore":
			$floor.texture = load("res://assets/levels/manor/manor_lore.png")
		elif type == "shop":
			$floor.texture = load("res://assets/levels/manor/manor_shop.png")
		else:
			$floor.texture = load("res://assets/levels/manor/manor_floor.png")
	
	if type == "enemy":	
		var layout = randi_range(0,1)
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
			
			var count = randi_range(level,level+2)
			while count > 0:
				var enemy = randi_range(1,1)
				if enemy == 1:
					temp = limbo_scene.instantiate()
				
				var locations = [0,1,2,3,4,5,6,7]
				var location = locations[randi() % locations.size()]
				if location == 0:
					temp.position = Vector2(64,64)
					locations.remove_at(location)
				elif location == 1:
					temp.position = Vector2(-64,64)
					locations.remove_at(location)
				elif location == 2:
					temp.position = Vector2(64,-64)
					locations.remove_at(location)
				elif location == 3:
					temp.position = Vector2(-64,-64)
					locations.remove_at(location)
				elif location == 4:
					temp.position = Vector2(128,128)
					locations.remove_at(location)
				elif location == 5:
					temp.position = Vector2(-128,128)
					locations.remove_at(location)
				elif location == 6:
					temp.position = Vector2(128,-128)
					locations.remove_at(location)
				elif location == 7:
					temp.position = Vector2(-128,-128)
					locations.remove_at(location)
				add_child(temp)
				count -= 1
			
		elif layout == 2:
			pass
		else: # blank
			pass

func _process(_delta):
	pass
