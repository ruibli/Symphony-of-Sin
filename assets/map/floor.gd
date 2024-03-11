extends StaticBody2D

@export var blocker_scene: PackedScene
@export var pedestal_scene: PackedScene
@export var exit_scene: PackedScene
@export var lap_scene: PackedScene

@export var limbo_scene: PackedScene

var blocker
var pedestal
var exit
var lap
var lap_level = 1

var type = "enemy"
var level = Glova.g_level()
var temp

func _ready():
	if level == 1: # level 1 manor assets
		$floor.texture = load("res://assets/map/manor/manor_floor.png")
		if type == "lore":
			$floor.texture = load("res://assets/map/manor/manor_lore.png")
	
	if type == "boss":
		blocker = blocker_scene.instantiate()
		blocker.position = Vector2(64,0)
		add_child(blocker)
		blocker = blocker_scene.instantiate()
		blocker.position = Vector2(-64,0)
		add_child(blocker)
		blocker = blocker_scene.instantiate()
		blocker.position = Vector2(0,64)
		add_child(blocker)
		blocker = blocker_scene.instantiate()
		blocker.position = Vector2(0,-64)
		add_child(blocker)
		
		if level == 1:
			temp = rand_enemy()	# spawn boss here
			temp.position = Vector2(0,-32)
			add_child(temp)
			
		exit = exit_scene.instantiate()
		exit.position = Vector2(128,-128)
		add_child(exit)
		
		if level == lap_level:
			lap = lap_scene.instantiate()
			lap .position = Vector2(-128,-128)
			add_child(lap)
		
		pedestal = pedestal_scene.instantiate()
		pedestal.position = Vector2(0,0)
		pedestal.type = "boss"
		add_child(pedestal)
	
	elif type == "spawn":
		pass
		
	elif type == "lore":
		pass
		
	elif type == "shop":
		pedestal = pedestal_scene.instantiate()
		pedestal.position = Vector2(0,0)
		pedestal.type = "shop"
		add_child(pedestal)
		
		pedestal = pedestal_scene.instantiate()
		pedestal.position = Vector2(128,128)
		pedestal.type = "shop"
		add_child(pedestal)
		
		pedestal = pedestal_scene.instantiate()
		pedestal.position = Vector2(-128,128)
		pedestal.type = "shop"
		add_child(pedestal)
		
		pedestal = pedestal_scene.instantiate()
		pedestal.position = Vector2(128,-128)
		pedestal.type = "shop"
		add_child(pedestal)
		
		pedestal = pedestal_scene.instantiate()
		pedestal.position = Vector2(-128,-128)
		pedestal.type = "shop"
		add_child(pedestal)
		
	else:	
		var layout = randi_range(0,4)
		if layout == 1:
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
			var locations = [0,1,2,3,4,5,6,7]
			while count > 0:
				temp = rand_enemy()	
				var location = locations[randi() % locations.size()]
				if location == 0:
					temp.position = Vector2(64,64)
				elif location == 1:
					temp.position = Vector2(-64,64)
				elif location == 2:
					temp.position = Vector2(64,-64)
				elif location == 3:
					temp.position = Vector2(-64,-64)
				elif location == 4:
					temp.position = Vector2(128,128)
				elif location == 5:
					temp.position = Vector2(-128,128)
				elif location == 6:
					temp.position = Vector2(128,-128)
				elif location == 7:
					temp.position = Vector2(-128,-128)
				locations.remove_at(locations.find(location,0))
				add_child(temp)
				count -= 1
			
			pedestal = pedestal_scene.instantiate()
			pedestal.position = Vector2(0,0)
			pedestal.type = "enemy"
			add_child(pedestal)
		
		elif layout == 2:
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(32,64)
			add_child(blocker)
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(64,32)
			add_child(blocker)
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(-32,64)
			add_child(blocker)
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(-64,32)
			add_child(blocker)
			
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(32,-64)
			add_child(blocker)
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(64,-32)
			add_child(blocker)
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(-32,-64)
			add_child(blocker)
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(-64,-32)
			add_child(blocker)
			
			var count = randi_range(level,level+2)
			var locations = [0,1,2,3,4,5,6,7]
			while count > 0:
				temp = rand_enemy()	
				var location = locations[randi() % locations.size()]
				if location == 0:
					temp.position = Vector2(32,32)
				elif location == 1:
					temp.position = Vector2(-32,32)
				elif location == 2:
					temp.position = Vector2(32,-32)
				elif location == 3:
					temp.position = Vector2(-32,-32)
				elif location == 4:
					temp.position = Vector2(128,128)
				elif location == 5:
					temp.position = Vector2(-128,128)
				elif location == 6:
					temp.position = Vector2(128,-128)
				elif location == 7:
					temp.position = Vector2(-128,-128)
				locations.remove_at(locations.find(location,0))
				add_child(temp)
				count -= 1
			
			pedestal = pedestal_scene.instantiate()
			pedestal.position = Vector2(0,0)
			pedestal.type = "enemy"
			add_child(pedestal)
		
		elif layout == 3:
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(32,96)
			add_child(blocker)
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(96,32)
			add_child(blocker)
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(-32,96)
			add_child(blocker)
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(-96,32)
			add_child(blocker)
			
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(32,-96)
			add_child(blocker)
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(96,-32)
			add_child(blocker)
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(-32,-96)
			add_child(blocker)
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(-96,-32)
			add_child(blocker)
			
			var count = randi_range(level,level+2)
			var locations = [0,1,2,3,4,5,6,7]
			while count > 0:
				temp = rand_enemy()	
				var location = locations[randi() % locations.size()]
				if location == 0:
					temp.position = Vector2(32,32)
				elif location == 1:
					temp.position = Vector2(-32,32)
				elif location == 2:
					temp.position = Vector2(32,-32)
				elif location == 3:
					temp.position = Vector2(-32,-32)
				elif location == 4:
					temp.position = Vector2(128,128)
				elif location == 5:
					temp.position = Vector2(-128,128)
				elif location == 6:
					temp.position = Vector2(128,-128)
				elif location == 7:
					temp.position = Vector2(-128,-128)
				locations.remove_at(locations.find(location,0))
				add_child(temp)
				count -= 1
			
			pedestal = pedestal_scene.instantiate()
			pedestal.position = Vector2(0,0)
			pedestal.type = "enemy"
			add_child(pedestal)
		
		elif layout == 4:
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(32,32)
			add_child(blocker)
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(64,32)
			add_child(blocker)
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(32,64)
			add_child(blocker)
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(64,64)
			add_child(blocker)
			
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(-32,32)
			add_child(blocker)
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(-64,32)
			add_child(blocker)
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(-32,64)
			add_child(blocker)
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(-64,64)
			add_child(blocker)
			
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(32,-32)
			add_child(blocker)
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(64,-32)
			add_child(blocker)
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(32,-64)
			add_child(blocker)
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(64,-64)
			add_child(blocker)
			
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(-32,-32)
			add_child(blocker)
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(-64,-32)
			add_child(blocker)
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(-32,-64)
			add_child(blocker)
			blocker = blocker_scene.instantiate()
			blocker.position = Vector2(-64,-64)
			add_child(blocker)
		
			var count = randi_range(level,level+2)
			var locations = [0,1,2,3,4,5,6,7]
			while count > 0:
				temp = rand_enemy()	
				var location = locations[randi() % locations.size()]
				if location == 0:
					temp.position = Vector2(0,32)
				elif location == 1:
					temp.position = Vector2(0,-32)
				elif location == 2:
					temp.position = Vector2(32,0)
				elif location == 3:
					temp.position = Vector2(-32,0)
				elif location == 4:
					temp.position = Vector2(128,128)
				elif location == 5:
					temp.position = Vector2(-128,128)
				elif location == 6:
					temp.position = Vector2(128,-128)
				elif location == 7:
					temp.position = Vector2(-128,-128)
				locations.remove_at(locations.find(location,0))
				add_child(temp)
				count -= 1
			
			pedestal = pedestal_scene.instantiate()
			pedestal.position = Vector2(0,0)
			pedestal.type = "enemy"
			add_child(pedestal)
			
		else: # empty
			var count = randi_range(level,level+2)
			var locations = [0,1,2,3,4,5,6,7]
			while count > 0:
				temp = rand_enemy()	
				var location = locations[randi() % locations.size()]
				if location == 0:
					temp.position = Vector2(32,32)
				elif location == 1:
					temp.position = Vector2(-32,32)
				elif location == 2:
					temp.position = Vector2(32,-32)
				elif location == 3:
					temp.position = Vector2(-32,-32)
				elif location == 4:
					temp.position = Vector2(32,0)
				elif location == 5:
					temp.position = Vector2(-32,0)
				elif location == 6:
					temp.position = Vector2(0,32)
				elif location == 7:
					temp.position = Vector2(0,-32)
				locations.remove_at(locations.find(location,0))
				add_child(temp)
				count -= 1
			pedestal = pedestal_scene.instantiate()
			pedestal.position = Vector2(0,0)
			pedestal.type = "enemy"
			add_child(pedestal)

func rand_enemy():
	var enemies = [1]
	var enemy = enemies[randi() % enemies.size()]
	if enemy == 1:
		return limbo_scene.instantiate()
