extends StaticBody2D

@export var boss_scene: PackedScene
@export var spawn_scene: PackedScene
@export var shop_scene: PackedScene
@export var lore_scene: PackedScene

@export var enemy_0_scene: PackedScene

var type = "enemy"
var level = Glova.g_level()
var temp

func _ready():	
	if level == 1: # level 1 manor assets
		$floor.texture = load("res://assets/map/manor/manor_floor.png")
	
	if type == "boss":
		temp = boss_scene.instantiate()
		add_child(temp)
	elif type == "spawn":
		temp = spawn_scene.instantiate()
		add_child(temp)
	elif type == "lore":
		pass
	elif type == "shop":
		temp = shop_scene.instantiate()
		add_child(temp)
	else:	
		var layout = randi_range(0,0)
		if layout == 1:
			temp = spawn_scene.instantiate()
		else:
			temp = enemy_0_scene.instantiate()
		add_child(temp)
