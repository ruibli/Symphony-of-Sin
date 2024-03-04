extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if Glova.get_level() == 1: # level 1 manor assets
		$blocker.texture = load("res://assets/map/manor/manor_blocker.png")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
