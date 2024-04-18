extends Control

var level = 1
var mod = 0

func _ready():
	hide()

func _process(_delta):
	if Input.is_action_pressed("pause"):
		if get_tree().paused == true: # unpause
			hide()
			get_tree().paused = false
		else: # pause
			show()
			get_tree().paused = true
			level = Glova.g_level(0)
			mod = Glova.g_mod(0)
	
	# $VBoxContainer/level_con/level.text = str(level)
	# $VBoxContainer/mod_con/mod.text = str(mod)
	# $VBoxContainer/time_con/attack_time.text = str(time)
