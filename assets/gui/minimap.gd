extends Node2D

@export var mini_floor: PackedScene

@onready var map_node = $MapNode

var can_swap = true
var wait = false
var spawn = false
var save = []
var mod

var x = -9
var y = 9

func _ready():
	mod = Glova.mod
	hide()

func _process(_delta):
	
	if Input.is_action_pressed("swap") and can_swap:
		can_swap = false
		$swap_cd.start()
		if is_visible():
			hide()
		else:
			show()
	position = Vector2(350-(x+2)*16,(-y+2)*16)
	
	if not wait:
			await get_tree().create_timer(0.05).timeout
			wait = true
			show()
	else:
		if Glova.mod != mod:
			mod = Glova.mod
			spawn = false
			save = []
			x = -9
			y = 9
			for i in range(0, map_node.get_child_count()):
				map_node.get_child(i).queue_free()
		if Glova.id == []:
			pass
		elif Glova.id[2] != "spawn" and !spawn:
			Glova.id = []
		else:
			$mininova.position = Vector2(Glova.id[0],Glova.id[1]) * 16
			if !save.has(Glova.id):
				spawn = true
				
				var temp = mini_floor.instantiate()
				temp.type = Glova.id[2]
				temp.right = Glova.id[3]
				temp.left = Glova.id[4]
				temp.down = Glova.id[5]
				temp.up = Glova.id[6]
				temp.position = Vector2(Glova.id[0],Glova.id[1]) * 16
				
				if Glova.id[0] > x:
					x = Glova.id[0]
				if Glova.id[1] < y:
					y = Glova.id[1]
				
				save.append(Glova.id)
				Glova.id = []
				map_node.add_child(temp)

func _on_swap_cd_timeout():
	can_swap = true
