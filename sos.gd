extends Node

@onready var generator = $generator
@export var nova_scene: PackedScene
var nova
var total = 0

func _ready():
	new_game()	
	
func new_game():
	Glova.reset()
	generator.new_dungeon()
	
	nova = nova_scene.instantiate()
	nova.position = generator.get_spawn()
	add_child(nova)	

func _process(delta):
	if Input.is_action_pressed("reset"):
		total += delta
	elif Input.is_action_just_released("reset"):
		total = 0
	$black.modulate= Color(0, 0, 0, 255*total/2)
	
	if total > 2: # r key
		get_tree().reload_current_scene()
	if Glova.g_level() == -1: # death
		# death screen
		get_tree().reload_current_scene()
	if Glova.g_level() == -2: # end game
		get_tree().quit()
