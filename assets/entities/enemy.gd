extends Node2D

@export var limbo_scene: PackedScene
@export var gluttony_scene: PackedScene
@export var greed_scene: PackedScene
@export var wrath_scene: PackedScene
@export var heresy_scene: PackedScene

#var enemies = ["heresy"]
var enemies = ["limbo","gluttony","greed","wrath","heresy"]
var temp

# Called when the node enters the scene tree for the first time.
func _ready():
	var enemy = enemies[randi() % enemies.size()]
	if enemy == "limbo":
		temp = limbo_scene.instantiate()
	elif enemy == "gluttony":
		temp = gluttony_scene.instantiate()
	elif enemy == "greed":
		temp = greed_scene.instantiate()
	elif enemy == "wrath":
		temp = wrath_scene.instantiate()
	elif enemy == "heresy":
		temp = heresy_scene.instantiate()
	add_child(temp)
