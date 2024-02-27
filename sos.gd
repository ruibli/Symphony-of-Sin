extends Node

@onready var generator = $generator
@export var nova_scene: PackedScene
var nova
@export var limbo_scene: PackedScene
var limbo


func _ready():
	
	generator.new_dungeon()
	
	nova = nova_scene.instantiate()
	nova.position = generator.get_spawn()
	add_child(nova)
	
	limbo = limbo_scene.instantiate()
	limbo.position = generator.get_spawn()
	add_child(limbo)

func _process(_delta):
	pass
