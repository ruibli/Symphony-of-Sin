extends Node

@onready var generator = $generator
@export var nova_scene: PackedScene
var nova
var total = 0

func _ready():
	$black.color = Color(0, 0, 0, 0)
	generator.new_dungeon()
	
	nova = nova_scene.instantiate()
	nova.position = generator.get_spawn()
	add_child(nova)
	
func _process(delta):
	if Input.is_action_pressed("reset"):
		total += delta
		$black.color = Color(0, 0, 0, total/2)
	if Input.is_action_just_released("reset"):
		total = 0
		$black.color = Color(0, 0, 0, 0)
	if total > 2:
		get_tree().reload_current_scene()
		Glova.reset()
