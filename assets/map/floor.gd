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
			$floor.texture = load("res://assets/map/manor/manor_boss.png")
		elif type == "spawn":
			$floor.texture = load("res://assets/map/manor/manor_spawn.png")
		elif type == "lore":
			$floor.texture = load("res://assets/map/manor/manor_lore.png")
		elif type == "shop":
			$floor.texture = load("res://assets/map/manor/manor_shop.png")
		else:
			$floor.texture = load("res://assets/map/manor/manor_floor.png")
	
	if type == "boss":
		pass
	elif type == "spawn":
		pass
	elif type == "lore":
		pass
	elif type == "shop":
		pass
	else:	
		var layout = randi_range(0,2)
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
				temp = rand_enemy()	
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
			
		elif layout == 2: # plus
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(32,64)
			add_child(blocker)
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(32,96)
			add_child(blocker)
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(64,32)
			add_child(blocker)
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(96,32)
			add_child(blocker)
			
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(-32,64)
			add_child(blocker)
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(-32,96)
			add_child(blocker)
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(-64,32)
			add_child(blocker)
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(-96,32)
			add_child(blocker)
			
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(32,-64)
			add_child(blocker)
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(32,-96)
			add_child(blocker)
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(64,-32)
			add_child(blocker)
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(96,-32)
			add_child(blocker)
			
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(-32,-64)
			add_child(blocker)
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(-32,-96)
			add_child(blocker)
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(-64,-32)
			add_child(blocker)
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(-96,-32)
			add_child(blocker)
			
			var count = randi_range(level,level+2)
			while count > 0:
				temp = rand_enemy()	
				var locations = [0,1,2,3,4,5,6,7]
				var location = locations[randi() % locations.size()]
				if location == 0:
					temp.position = Vector2(64,64)
					locations.remove_at(location)
				elif location == 1:
					temp.position = Vector2(96,96)
					locations.remove_at(location)
				elif location == 2:
					temp.position = Vector2(-64,64)
					locations.remove_at(location)
				elif location == 3:
					temp.position = Vector2(-96,96)
					locations.remove_at(location)
				elif location == 4:
					temp.position = Vector2(64,-64)
					locations.remove_at(location)
				elif location == 5:
					temp.position = Vector2(96,-96)
					locations.remove_at(location)
				elif location == 6:
					temp.position = Vector2(-64,-64)
					locations.remove_at(location)
				elif location == 7:
					temp.position = Vector2(-96,-96)
					locations.remove_at(location)
				add_child(temp)
				count -= 1
		
		else: # empty
			var count = randi_range(level,level+2)
			while count > 0:
				temp = rand_enemy()	
				var locations = [0,1,2,3,4,5,6,7]
				var location = locations[randi() % locations.size()]
				if location == 0:
					temp.position = Vector2(32,32)
					locations.remove_at(location)
				elif location == 1:
					temp.position = Vector2(-32,32)
					locations.remove_at(location)
				elif location == 2:
					temp.position = Vector2(32,-32)
					locations.remove_at(location)
				elif location == 3:
					temp.position = Vector2(-32,-32)
					locations.remove_at(location)
				elif location == 4:
					temp.position = Vector2(32,0)
					locations.remove_at(location)
				elif location == 5:
					temp.position = Vector2(-32,0)
					locations.remove_at(location)
				elif location == 6:
					temp.position = Vector2(0,32)
					locations.remove_at(location)
				elif location == 7:
					temp.position = Vector2(0,-32)
					locations.remove_at(location)
				add_child(temp)
				count -= 1

func rand_enemy():
	var enemy = randi_range(1,1)
	if enemy == 1:
		return limbo_scene.instantiate()
