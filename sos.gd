extends Node

@onready var generator = $generator

func _ready():
	generator.new_dungeon()

func _process(_delta):
	pass
