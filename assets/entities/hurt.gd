extends Area2D

func hit(ow):
	owner.hit(ow)

func boop(dir):
	owner.boop(dir)

func is_active():
	return owner.is_active()
