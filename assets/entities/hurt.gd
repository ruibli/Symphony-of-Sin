extends Area2D

func hit(ow,nam,dir):
	owner.hit(ow,nam,dir)

func boop(dir):
	owner.boop(dir)

func is_active():
	return owner.is_active()
