extends Area2D

func hit(ow,pos,gain):
	owner.hit(ow,pos,gain)

func boop(dir):
	owner.boop(dir)

func is_active():
	return owner.is_active()
