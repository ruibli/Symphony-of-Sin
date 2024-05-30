extends Area2D

func hit(ow,pos,nam,dir):
	owner.hit(ow,pos,nam,dir)

func boop(dir):
	owner.boop(dir)

func is_active():
	return owner.is_active()
