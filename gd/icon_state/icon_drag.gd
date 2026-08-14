extends IconStateBase

func enter():
	host.drag_offset = host.global_position - host.press_mouse_pos
	host.start_global_pos = host.global_position
	host.icon_copy.visible = true
	host.back_light_copy.visible = true
	host.set_all_opacity(0.7)

func exit():
	host.icon_copy.visible = false
	host.back_light_copy.visible = false
	
	var start_snap_pos:Vector2 = host.round_pos(host.start_global_pos)
	var ready_to_pos:Vector2 = host.round_pos(host.position)
	
	if Preload.pos_to_node.has(ready_to_pos):
		var other:Node = Preload.pos_to_node[ready_to_pos]
		if other != host:
			other.position = start_snap_pos
	host.position = ready_to_pos

	Preload.refresh_map()
	host.set_all_opacity(1)

func physics_update(_delta: float):
	# 持续跟随角色
	host.global_position = host.mouse.global_position + host.drag_offset
	host.icon_copy.global_position = host.start_global_pos - Vector2(0,30)
	host.back_light_copy.global_position = host.start_global_pos
