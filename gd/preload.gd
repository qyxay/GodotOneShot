extends Node

const PreLoad = preload("uid://dmbo167o5eay5")

const MouseClick = preload("uid://bxrqgbpn57gcr")
const MouseIdle = preload("uid://bieu08fx1twol")
const MousePrepush = preload("uid://c4xe5mktk84se")
const MousePush = preload("uid://c5g04ctlotrfa")

const theme_color = Color("9262f9ff")

var pos_to_node: Dictionary = {}
func refresh_map():
	pos_to_node.clear()
	var all_icons = get_tree().get_nodes_in_group("icon_group")
	for icon in all_icons:
		if not icon.is_inside_tree():
			continue
		var p = icon.round_pos(icon.position)
		if not pos_to_node.has(p):
			pos_to_node[p] = icon
		else:
			print("Errow: ",p,"exists icon！")
func remove_pos(pos:Vector2):
	if pos_to_node.has(pos):
		pos_to_node.erase(pos)
'''
呵呵，又是AI写的。
pos_to_node维护的是桌面上的位置坐标到icon节点的映射。
我觉得可以在移动和交换icon时维护数组，就能做到O(1)的时间复杂度。
然而这样做会报错。
O(n)复杂度就这样吧，反正icon节点不多。
'''

var last_click_time:float = 0.0
func is_double_click() -> bool:
	var now: float = Time.get_ticks_msec() / 1000.0
	var is_double: bool = (now - last_click_time) <= 0.3
	last_click_time = now
	return is_double

func round_pos(pos:Vector2):
	var snap_x:float = clamp(round(pos.x / 300) * 300 + 100, -800, 700)
	var snap_y:float = clamp(round(pos.y / 200) * 200, -400, 200)
	var snap_pos:Vector2 = Vector2(snap_x, snap_y)
	return snap_pos
