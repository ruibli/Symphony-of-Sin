extends Node2D

var dungeon = {}
var temp
@export var wall_scene: PackedScene
@export var fill_scene: PackedScene
@export var floor_scene: PackedScene

var room = preload("res://assets/levels/room.tscn")

var min_number_rooms = 10
var max_number_rooms = 16
var generation_chance = 20
var boss = false # red
var spawn = false # blue
var lore = false # purple
var shop = false # yellow

var spawn_point
var level

@onready var map_node = $MapNode

func get_spawn():
	return spawn_point

func new_dungeon(l):
	randomize()
	dungeon = generate(randf_range(-1000, 1000))
	level = l
	load_map()
	
func load_map():
	
	boss = false # red
	spawn = false # blue
	lore = false # purple
	shop = false # yellow
	
	for i in range(0, map_node.get_child_count()):
		map_node.get_child(i).queue_free()
		
	for i in dungeon.keys():
		temp = floor_scene.instantiate()
		var c_rooms = dungeon.get(i).connected_rooms
		if(!boss && dungeon.get(i).number_of_connections == 1):
			boss = true
			temp.type = "boss"
		elif(!spawn && dungeon.get(i).number_of_connections >= 3):
			spawn = true
			temp.type = "spawn"
			spawn_point = i * 320
		elif(!lore && dungeon.get(i).number_of_connections == 1):
			lore = true
			temp.type = "lore"
		elif(!shop && dungeon.get(i).number_of_connections == 1):
			shop = true
			temp.type = "shop"
		temp.level = level
		temp.position = i * 320
		map_node.add_child(temp)
		
		temp = wall_scene.instantiate()
		temp.position = i * 320
		map_node.add_child(temp)
		
		if(c_rooms.get(Vector2(1, 0)) == null):
			temp = fill_scene.instantiate()
			temp.position = i * 320 + Vector2(160, 0)
			map_node.add_child(temp)
		if(c_rooms.get(Vector2(-1, 0)) == null):
			temp = fill_scene.instantiate()
			temp.position = i * 320 - Vector2(160, 0)
			map_node.add_child(temp)
		if(c_rooms.get(Vector2(0, 1)) == null):
			temp = fill_scene.instantiate()
			temp.position = i * 320 + Vector2(0, 160)
			map_node.add_child(temp)
		if(c_rooms.get(Vector2(0, -1)) == null):
			temp = fill_scene.instantiate()
			temp.position = i * 320 - Vector2(0, 160)
			map_node.add_child(temp)
			
func generate(room_seed):
	seed(room_seed)
	var generated = {}
	var size = floor(randi_range(min_number_rooms, max_number_rooms))
	
	generated[Vector2(0,0)] = room.instantiate()
	size -= 1
	
	while(size > 0):
		for i in generated.keys():
			if(randf_range(0,100) < generation_chance):
				var direction = randi_range(0,4)
				if(direction < 1):
					var new_room_position = i + Vector2(1, 0)
					if(!generated.has(new_room_position)):
						generated[new_room_position] = room.instantiate()
						size -= 1
					if(generated.get(i).connected_rooms.get(Vector2(1, 0)) == null):
						connect_rooms(generated.get(i), generated.get(new_room_position), Vector2(1, 0))
				elif(direction < 2):
					var new_room_position = i + Vector2(-1, 0)
					if(!generated.has(new_room_position)):
						generated[new_room_position] = room.instantiate()
						size -= 1
					if(generated.get(i).connected_rooms.get(Vector2(-1, 0)) == null):
						connect_rooms(generated.get(i), generated.get(new_room_position), Vector2(-1, 0))
				elif(direction < 3):
					var new_room_position = i + Vector2(0, 1)
					if(!generated.has(new_room_position)):
						generated[new_room_position] = room.instantiate()
						size -= 1
					if(generated.get(i).connected_rooms.get(Vector2(0, 1)) == null):
						connect_rooms(generated.get(i), generated.get(new_room_position), Vector2(0, 1))
				elif(direction < 4):
					var new_room_position = i + Vector2(0, -1)
					if(!generated.has(new_room_position)):
						generated[new_room_position] = room.instantiate()
						size -= 1
					if(generated.get(i).connected_rooms.get(Vector2(0, -1)) == null):
						connect_rooms(generated.get(i), generated.get(new_room_position), Vector2(0, -1))
	while(!is_interesting(generated)):
		for i in generated.keys():
			generated.get(i).queue_free()
		var sed = room_seed * randf_range(-1,1) + randf_range(-100,100)
		generated = generate(sed)
	return generated

func connect_rooms(room1, room2, direction):
	room1.connected_rooms[direction] = room2
	room2.connected_rooms[-direction] = room1
	room1.number_of_connections += 1
	room2.number_of_connections += 1

func is_interesting(generated):
	var room_with_one = 0
	for i in generated.keys():
		if(generated.get(i).number_of_connections == 1):
			room_with_one += 1
	var room_with_three = 0
	for i in generated.keys():
		if(generated.get(i).number_of_connections >= 3):
			room_with_three += 1
	return room_with_one >= 4 && room_with_three <= 4
