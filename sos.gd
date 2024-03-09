extends Node

@onready var generator = $generator
@export var nova_scene: PackedScene
var nova
var total = 0
var current_level = 1
var current_lap = 1

func _ready():
	new_game()	
	
func new_game():
	Glova.reset()
	generator.new_dungeon()
	
	nova = nova_scene.instantiate()
	nova.position = generator.get_spawn()
	add_child(nova)	

func new_floor():
	generator.new_dungeon()
	nova.position = generator.get_spawn()
	Glova.g_enemies(-Glova.g_enemies())

func _process(delta):
	var level = Glova.g_level()
	var lap = Glova.g_lap()
	
	if Input.is_action_pressed("reset"):
		total += delta
	elif Input.is_action_just_released("reset"):
		total = 0
	$black.modulate= Color(0, 0, 0, 255*total/2)
	
	if total > 2: # r key
		get_tree().reload_current_scene()
	elif level == -1: # death
		# death screen
		get_tree().reload_current_scene()
	elif level == -2: # end game
		get_tree().quit()
	elif level != current_level:
		new_floor()
		current_level = level
	elif lap != current_lap:
		new_floor()
		current_lap = lap
