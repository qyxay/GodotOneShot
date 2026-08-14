extends Node

var mouse:CharacterBody2D
var animation:AnimatedSprite2D
func beginning():
	if mouse == null:
		mouse = get_parent()
	animation = get_parent().get_node("AnimatedSprite2D")
	mouse.state = "push"
	animation.play("push")
	
func _physics_process(_delta: float) -> void:
	if Input.is_action_just_released("mouse_left"):
		if mouse.is_in_icon:
			mouse.change_state(Preload.MouseClick)
		if mouse == null: return
		'''
		别的函数里也有这个玄学东西,
		因为不知道为什么，mouse有时候会为null
		
		如果把“是否在窗口”和“是在图标”的判断交换位置
		会让bug更容易触发（依旧玄学）
		'''
		if mouse.is_on_window:
			mouse.change_state(Preload.MousePrepush)
	'''
	完全弄清这个函数是干什么之前，不要动它。
	这个函数牵扯到的逻辑很复杂，很巧，我也不好讲清。
	
	目前它还有bug：
		如果快速移动窗口有可能导致:
		鼠标脱离窗口后，依然保持push状态
		不能通过判断是否在窗口上解决，因为：
	is_on_window也有bug：
		在移动窗口过程中，
		is_on_window不知为何会有一段时间为false
	于是如果加上判断“鼠标是否在窗口”上，鼠标就会抽风。
	不知道咋修，但这个bug比较难触发，暂时不管了。
	'''
