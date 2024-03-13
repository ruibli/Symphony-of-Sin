extends Node2D

@export var enemy_scene: PackedScene
@export var pedestal_scene: PackedScene
var level = Glova.g_level()
var temp

func _ready():
	var count = randi_range(level,level) #+2)
	var locations = [0,1,2,3,4,5,6,7]
	while count > 0:
		temp = enemy_scene.instantiate()
		var location = locations[randi() % locations.size()]
		if location == 0:
			temp.position = $Marker2D.position
		elif location == 1:
			temp.position = $Marker2D2.position
		elif location == 2:
			temp.position = $Marker2D3.position
		elif location == 3:
			temp.position = $Marker2D4.position
		elif location == 4:
			temp.position = $Marker2D5.position
		elif location == 5:
			temp.position = $Marker2D6.position
		elif location == 6:
			temp.position = $Marker2D7.position
		elif location == 7:
			temp.position = $Marker2D8.position
		locations.remove_at(locations.find(location,0))
		add_child(temp)
		count -= 1
			
	temp = pedestal_scene.instantiate()
	temp.position = Vector2(0,0)
	temp.type = "enemy"
	add_child(temp)
