extends Node
class_name IconStateBase

# 持有状态机父节点（IconRoot）
var host

# 状态进入时执行
func enter():
	pass

# 状态退出时执行
func exit():
	pass

# 每帧更新（_physics_process）
func physics_update(_delta: float):
	pass

# 鼠标输入回调（可选，统一转发）
func handle_input(_event: InputEvent):
	pass
