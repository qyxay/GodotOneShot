extends Node

var mouse:CharacterBody2D
var animation:AnimatedSprite2D
func beginning():
	mouse = get_parent()
	animation = get_parent().get_node("AnimatedSprite2D")
	mouse.state = "idle"
	animation.play("idle")
	
func _physics_process(_delta: float) -> void:
	if mouse.is_on_window:
		mouse.change_state(Preload.MousePrepush)
	
	# if mouse == null: return
	
	if mouse.is_in_icon:
		mouse.change_state(Preload.MouseClick)
	
	
	
	
