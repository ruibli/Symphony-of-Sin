extends StaticBody2D

var state = 1 # 1 = not on screen, 2 = on screen waiting for no enemies, 3 = ready to tp

func _ready():
	$exit.visible = false

func _process(_delta):
	if state == 2 and Glova.enemies > 0:
		$Timer.start()
	for _area in $ExitArea.get_overlapping_areas():
		if state == 3:
			if Glova.level == Glova.last:
				Glova.level = -2
			elif Glova.level < Glova.last:
				Glova.level = Glova.level + 1
				Glova.mod = Glova.mod + 1

func _on_timer_timeout():
	$exit.visible = true
	state = 3

func _on_visible_on_screen_notifier_2d_screen_entered():
	$Timer.start()
	state = 2
	$exit.visible = false

func _on_visible_on_screen_notifier_2d_screen_exited():
	state = 1
	$exit.visible = false
