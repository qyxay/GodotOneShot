extends Node

var mouse:CharacterBody2D
var animation:AnimatedSprite2D
func beginning():
	mouse = get_parent()
	animation = mouse.get_node("AnimatedSprite2D")
	mouse.state = "click"
	animation.play("click")

func _physics_process(_delta: float) -> void:
	if not mouse.is_in_icon:
		mouse.change_state(Preload.MouseIdle)
		
	if mouse == null: return
	
	if mouse.is_on_window:
		mouse.change_state(Preload.MousePrepush)
	
	if mouse == null: return
	
	if mouse.is_in_icon and Input.is_action_pressed("mouse_left"):
		mouse.change_state(Preload.MousePush)
	
	
