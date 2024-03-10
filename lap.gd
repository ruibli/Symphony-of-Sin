extends StaticBody2D

var state = 1 # 1 = not on screen, 2 = on screen waiting for no enemies, 3 = ready to tp
var lap = Glova.g_lap()

func _ready():
	$lap.visible = false

func _process(_delta):
	if state == 2 and Glova.g_enemies() > 0:
		$Timer.start()

func _on_lap_area_area_entered(_area):
	if state == 3:
		Glova.g_level(1)
		Glova.g_lap(lap + 1)

func _on_timer_timeout():
	$lap.visible = true
	state = 3
	
func _on_visible_on_screen_notifier_2d_screen_entered():
	if state == 1:
		$Timer.start()
		state = 2

func _on_visible_on_screen_notifier_2d_screen_exited():
	state = 1
	$lap.visible = false
