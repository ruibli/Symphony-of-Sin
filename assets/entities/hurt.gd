extends Area2D

func hit(ow,pos):
	owner.hit(ow,pos)

func boop(dir):
	owner.boop(dir)

func is_active():
	return owner.is_active()
