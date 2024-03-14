extends Node2D

@export var limbo_scene: PackedScene

var enemies = [1]
var temp

# Called when the node enters the scene tree for the first time.
func _ready():
	var enemy = enemies[randi() % enemies.size()]
	if enemy == 1:
		temp = limbo_scene.instantiate()
	add_child(temp)
