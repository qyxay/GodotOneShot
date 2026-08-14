extends IconStateBase

func enter():
	host.back_light.visible = true

func exit():
	host.back_light.visible = false

func physics_update(_delta: float):
	pass
