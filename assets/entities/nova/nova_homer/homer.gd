extends CharacterBody2D

var nam = "homer"
var speed = 300
var damage = 0.1
var dir
var wait = false
var enemies = []

func _ready():
	$Timer.start()

func _process(_delta):
	if not wait:
		velocity = Vector2(0,0)
		await get_tree().create_timer(0.15).timeout
		wait = true
	for area in $homereye.get_overlapping_areas():
		if area.is_active() == true:
			enemies.append(area.global_position)
	if enemies.size() > 0:
		$NavigationAgent2D.set_target_position(enemies[0])
		var current_agent_position = global_position
		var next_path_position = $NavigationAgent2D.get_next_path_position()
		velocity = (next_path_position - current_agent_position).normalized() * speed
		$NavigationAgent2D.set_velocity(velocity)
	else:
		queue_free()
	
	for area in $homerhit.get_overlapping_areas():
		area.hit(damage,nam,dir)
		queue_free()
	
	for index in get_slide_collision_count():
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_roomdetector_area_entered(area: Area2D) -> void:
	if area.get_name() == 'CameraArea' and wait == true:
		queue_free()

func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	velocity = safe_velocity.normalized() * speed
	move_and_slide()

func _on_timer_timeout():
	queue_free()
