extends Node2D

var dungeon = {}
var node_sprite = load("res://assets/levels/castle/castle_center.png")
var branch_sprite = load("res://assets/levels/castle/castle_path.png")

@onready var map_node = $MapNode

func _ready():
	randomize()
	dungeon = DungeonGeneration.generate(randf_range(-1000, 1000))
	load_map()

func load_map():
	for i in range(0, map_node.get_child_count()):
		map_node.get_child(i).queue_free()
		
	for i in dungeon.keys():
		var temp = Sprite2D.new()
		temp.texture = node_sprite
		map_node.add_child(temp)
		temp.z_index = 0
		temp.position = i * 320
		var c_rooms = dungeon.get(i).connected_rooms
		if(c_rooms.get(Vector2(1, 0)) != null):
			temp = Sprite2D.new()
			temp.texture = branch_sprite
			map_node.add_child(temp)
			temp.z_index = 1
			temp.position = i * 320 + Vector2(160, 0.5)
		if(c_rooms.get(Vector2(0, 1)) != null):
			temp = Sprite2D.new()
			temp.texture = branch_sprite
			map_node.add_child(temp)
			temp.z_index = 1
			temp.rotation_degrees = 90
			temp.position = i * 320 + Vector2(-0.5, 160)
