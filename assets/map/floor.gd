extends StaticBody2D

@export var boss_scene: PackedScene
@export var spawn_scene: PackedScene
@export var shop_scene: PackedScene
@export var lore_scene: PackedScene

@export var enemy_0_scene: PackedScene
@export var enemy_1_scene: PackedScene
@export var enemy_2_scene: PackedScene
@export var enemy_3_scene: PackedScene
@export var enemy_4_scene: PackedScene
@export var enemy_5_scene: PackedScene
@export var enemy_6_scene: PackedScene
@export var enemy_7_scene: PackedScene
@export var enemy_8_scene: PackedScene
@export var enemy_9_scene: PackedScene
@export var enemy_10_scene: PackedScene

@export var enemy_scene: PackedScene
@export var pedestal_scene: PackedScene
@export var lectern_scene: PackedScene
@export var exit_scene: PackedScene
@export var lap_scene: PackedScene

var type = "enemy"
var level = Glova.g_level()
var temp
var room
var on = false
var id
var lap_level = 1

func _ready():	
	if level == 1: # level 1 manor assets
		$floor.texture = load("res://assets/map/manor/manor_floor.png")
	
	if type == "boss":
		room = boss_scene.instantiate()
		add_child(room)
		
		if level == 1: # spawn boss here
			temp = enemy_scene.instantiate()
			temp.position = room.get_node("Marker2D").position
			add_child(temp)
			
		temp = exit_scene.instantiate()
		temp.position = Vector2(128,-128)
		add_child(temp)
		
		if level == lap_level:
			temp = lap_scene.instantiate()
			temp.position = Vector2(-128,-128)
			add_child(temp)
		
		temp = pedestal_scene.instantiate()
		temp.position = Vector2(0,0)
		temp.type = "boss"
		add_child(temp)
		
	elif type == "spawn":
		room = spawn_scene.instantiate()
		add_child(room)
	
	elif type == "lore":
		room = lore_scene.instantiate()
		add_child(room)
		
		temp = pedestal_scene.instantiate()
		temp.position = Vector2(0,64)
		temp.type = "lore"
		add_child(temp)
		
		temp = lectern_scene.instantiate()
		temp.position = Vector2(0,-64)
		add_child(temp)
	
	elif type == "shop":
		room = shop_scene.instantiate()
		add_child(room)
		
		temp = pedestal_scene.instantiate()
		temp.position = Vector2(0,0)
		temp.type = "shop"
		add_child(temp)
		
		temp = pedestal_scene.instantiate()
		temp.position = Vector2(96,96)
		temp.type = "shop"
		add_child(temp)
		
		temp = pedestal_scene.instantiate()
		temp.position = Vector2(-96,96)
		temp.type = "shop"
		add_child(temp)
		
		temp = pedestal_scene.instantiate()
		temp.position = Vector2(96,-96)
		temp.type = "shop"
		add_child(temp)
		
		temp = pedestal_scene.instantiate()
		temp.position = Vector2(-96,-96)
		temp.type = "shop"
		add_child(temp)

	else:	
		var layout = randi_range(0,10)
		if layout == 1:
			room = enemy_1_scene.instantiate()
		elif layout == 2:
			room = enemy_2_scene.instantiate()
		elif layout == 3:
			room = enemy_3_scene.instantiate()
		elif layout == 4:
			room = enemy_4_scene.instantiate()
		elif layout == 5:
			room = enemy_5_scene.instantiate()
		elif layout == 6:
			room = enemy_6_scene.instantiate()
		elif layout == 7:
			room = enemy_7_scene.instantiate()
		elif layout == 8:
			room = enemy_8_scene.instantiate()
		elif layout == 9:
			room = enemy_9_scene.instantiate()
		elif layout == 10:
			room = enemy_10_scene.instantiate()
		else:
			room = enemy_0_scene.instantiate()
		add_child(room)
		
		var count = randi_range(level,level+2)
		var locations = [0,1,2,3,4,5,6,7]
		while count > 0: # enemy spawning
			temp = enemy_scene.instantiate()
			var location = locations[randi() % locations.size()]
			if location == 0:
				temp.position = room.get_node("Marker2D").position
			elif location == 1:
				temp.position = room.get_node("Marker2D2").position
			elif location == 2:
				temp.position = room.get_node("Marker2D3").position
			elif location == 3:
				temp.position = room.get_node("Marker2D4").position
			elif location == 4:
				temp.position = room.get_node("Marker2D5").position
			elif location == 5:
				temp.position = room.get_node("Marker2D6").position
			elif location == 6:
				temp.position = room.get_node("Marker2D7").position
			elif location == 7:
				temp.position = room.get_node("Marker2D8").position
			locations.remove_at(locations.find(location,0))
			add_child(temp)
			count -= 1
			
		temp = pedestal_scene.instantiate()
		temp.position = Vector2(0,0)
		temp.type = "enemy"
		add_child(temp)

func _process(_delta):
	if Glova.spawn([0]) != [0,0] and on:
		temp = pedestal_scene.instantiate()
		temp.position = Vector2(0,32)
		temp.type = "debug"
		temp.item = Glova.spawn([0])[0]
		temp.nam = Glova.spawn([0])[1]
		Glova.spawn([0,0])
		add_child(temp)

func _on_visible_on_screen_notifier_2d_screen_entered():
	on = true
	Glova.g_ids([id.x,id.y,type])

func _on_visible_on_screen_notifier_2d_screen_exited():
	on = false
