extends Node2D

@export var mini_floor: PackedScene

var can_swap = true
var wait = false

var save = []
var ids = []

var x = 0
var y = 0

func _process(_delta):
	
	if Input.is_action_pressed("swap") and can_swap:
		can_swap = false
		$swap_cd.start()
		if is_visible():
			hide()
		else:
			show()
	position = Vector2(350-(x+4)*8,(-y+4)*8)
	
	if not wait:
			await get_tree().create_timer(0.25).timeout
			wait = true
	else:
		ids = Glova.g_ids([0])
		
		if ids == []:
			get_tree().reload_current_scene()
		elif !save.has(ids[ids.size()-1]):
			var id = ids[ids.size()-1]
			var temp = mini_floor.instantiate()
			temp.type = id[2]
			temp.right = id[3]
			temp.left = id[4]
			temp.down = id[5]
			temp.up = id[6]
			temp.position = Vector2(id[0],id[1]) * 8
			
			if id[0] > x:
				x = id[0]
			if id[1] < y:
				y = id[1]
			
			add_child(temp)
			save.append(id)


func _on_swap_cd_timeout():
	can_swap = true
