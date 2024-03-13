extends Node2D

@export var pedestal_scene: PackedScene
var temp

func _ready():
	temp = pedestal_scene.instantiate()
	temp.position = Vector2(0,0)
	temp.type = "shop"
	add_child(temp)
		
	temp = pedestal_scene.instantiate()
	temp.position = Vector2(96,96)
	temp.type = "shop"
	add_child(temp)
		
	temp = pedestal_scene.instantiate()
	temp.position = Vector2(-96,96)
	temp.type = "shop"
	add_child(temp)
		
	temp = pedestal_scene.instantiate()
	temp.position = Vector2(96,-96)
	temp.type = "shop"
	add_child(temp)
		
	temp = pedestal_scene.instantiate()
	temp.position = Vector2(-96,-96)
	temp.type = "shop"
	add_child(temp)
