extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if Glova.get_level() == 1: # level 1 manor assets
		$fill.texture = load("res://assets/map/manor/manor_fill.png")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
