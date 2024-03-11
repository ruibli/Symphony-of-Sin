extends Node

@onready var generator = $generator
@export var nova_scene: PackedScene
var nova
var total = 0
var current_level = 1
var current_lap = 1
var active = true

func _ready():
	nova = nova_scene.instantiate()
	add_child(nova)
	new_game()
	
func new_game():
	Glova.reset()
	generator.new_dungeon()
	nova.position = generator.get_spawn()
	$CanvasLayer/black/AnimationPlayer.play("clear")
	active = true

func new_floor():
	generator.new_dungeon()
	nova.position = generator.get_spawn()
	Glova.g_enemies(-999)
	$CanvasLayer/black/AnimationPlayer.play("clear")
	active = true

func _process(delta):
	if active:
		var level = Glova.g_level()
		var lap = Glova.g_lap()
	
		if Input.is_action_pressed("reset"):
			total += delta
		elif Input.is_action_just_released("reset"):
			total = 0
		$CanvasLayer/black.modulate = Color(0, 0, 0, total/2)
	
		if total > 2: # r key
			active = false
			get_tree().reload_current_scene()
		elif level == -1: # death
			$CanvasLayer/black/AnimationPlayer.play("black")
			active = false
			get_tree().reload_current_scene()
		elif level == -2: # end game
			$CanvasLayer/black/AnimationPlayer.play("black")
			active = false
			get_tree().quit()
		elif level != current_level:
			$CanvasLayer/black/AnimationPlayer.play("black")
			active = false
			new_floor()
			current_level = level
		elif lap != current_lap:
			$CanvasLayer/black/AnimationPlayer.play("black")
			active = false
			new_floor()
			current_lap = lap
