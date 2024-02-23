extends Node

@onready var generator = $generator
@export var nova_scene: PackedScene
var nova

func _ready():
	generator.new_dungeon()
	
	nova = nova_scene.instantiate()
	nova.position = generator.get_spawn()
	add_child(nova)

func _process(_delta):
	pass
