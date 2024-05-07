extends Node2D

@export var mini_floor: PackedScene

var can_swap = true
var wait = false
var spawn = false
var save = []
var id = []

var x = -9
var y = 9

func _ready():
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
		id = Glova.g_id([0])
		
		if id == [-1]:
			get_tree().reload_scene()
		elif id == []:
			pass
		elif id[2] != "spawn" and !spawn:
			Glova.g_id([])
		else:
			$mininova.position = Vector2(id[0],id[1]) * 16
			if !save.has(id):
				spawn = true
				
				var temp = mini_floor.instantiate()
				temp.type = id[2]
				temp.right = id[3]
				temp.left = id[4]
				temp.down = id[5]
				temp.up = id[6]
				temp.position = Vector2(id[0],id[1]) * 16
				
				if id[0] > x:
					x = id[0]
				if id[1] < y:
					y = id[1]
				
				Glova.g_id([])
				add_child(temp)
				save.append(id)

func _on_swap_cd_timeout():
	can_swap = true
