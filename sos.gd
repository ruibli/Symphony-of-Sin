extends Node

@onready var generator = $generator


func _ready():
	print("test2")
	generator.new_dungeon()

func _process(_delta):
	pass
