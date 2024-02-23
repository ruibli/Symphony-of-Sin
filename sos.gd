extends Node

@onready var generator = $generator
var nova

func _ready():
	generator.new_dungeon()
	# nova.position = generator.spawn_point()

func _process(_delta):
	pass
