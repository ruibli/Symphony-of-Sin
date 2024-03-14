extends Node2D

@export var enemy_scene: PackedScene
@export var pedestal_scene: PackedScene
var level = Glova.g_level()
var temp

func _ready():
	
