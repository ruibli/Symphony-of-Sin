extends Node2D

@export var limbo_scene: PackedScene
@export var gluttony_scene: PackedScene

var enemies = [1,3]
var temp

# Called when the node enters the scene tree for the first time.
func _ready():
	var enemy = enemies[randi() % enemies.size()]
	if enemy == 1:
		temp = limbo_scene.instantiate()
	elif enemy == 3:
		temp = gluttony_scene.instantiate()
	add_child(temp)
