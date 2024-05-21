extends Node

@onready var generator = $generator
@export var nova_scene: PackedScene
var nova
var total = 0
var current_mod = 0
var active = true

func _ready():
	nova = nova_scene.instantiate()
	nova.cam = false
	add_child(nova)
	new_game()
	
func new_game():
	$fade/black.modulate = Color(0, 0, 0, 1)
	Glova.new_game()
	generator.new_dungeon()
	nova.cam = false
	nova.position = generator.get_spawn()
	$fade/black/AnimationPlayer.play("clear")
	active = true
	await get_tree().create_timer(0.25).timeout
	nova.cam = true

func new_floor():
	$fade/black.modulate = Color(0, 0, 0, 1)
	Glova.new_floor()
	generator.new_dungeon()
	nova.cam = false	
	nova.position = generator.get_spawn()
	$fade/black/AnimationPlayer.play("clear")
	active = true
	await get_tree().create_timer(0.25).timeout
	nova.cam = true

func _process(delta):
	if active:
		var level = Glova.level
		var mod = Glova.mod
	
		if Input.is_action_pressed("reset"):
			total += delta
		elif Input.is_action_just_released("reset"):
			total = 0
		$fade/black.modulate = Color(0, 0, 0, total/2)
	
		if total > 2: # r key
			active = false
			get_tree().reload_current_scene()
		elif level == -1: # death
			active = false
			get_tree().reload_current_scene()
		elif level == -2: # end game
			active = false
			get_tree().quit()
		elif mod != current_mod:
			active = false
			new_floor()
			current_mod = mod
