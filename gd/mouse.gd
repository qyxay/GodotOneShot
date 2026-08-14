extends CharacterBody2D

@onready var state_machine: Node = $StateMachine #状态机
@onready var mouse_left: AudioStreamPlayer2D = $"../Audio/MouseClick"
@onready var mouse_unclick: AudioStreamPlayer2D = $"../Audio/MouseUnclick"

var is_in_icon:bool = false
var icon:Area2D
var last_click_time:float = 0.0
var is_on_window:bool = false
var state:String

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	state_machine.set_physics_process(true)
	
	'''
	var all_icons:Array[Node] = get_tree().get_nodes_in_group("icon_group")
	for _icon:Node in all_icons:
		if _icon is Area2D:
			_icon.connect("body_entered", _on_icon_body_entered)
			_icon.connect("body_exited", _on_icon_body_exited)
	
	var all_windows:Array[Node] = get_tree().get_nodes_in_group("window_group")
	for _window:Node in all_windows:
		if _window is Area2D:
			_window.connect("body_entered", _on_window_body_entered)
			_window.connect("body_exited", _on_window_body_exited)
			
	'''
	
	state = "idle"
	change_state(Preload.MouseIdle)

func _physics_process(_delta: float) -> void:
	input()
	global_position = get_global_mouse_position()
	if Preload.pos_to_node.has(Preload.round_pos(global_position)):
		is_in_icon = true
	else: is_in_icon = false
	
func input():
	if Input.is_action_just_pressed("mouse_left"):
		mouse_unclick.stop()
		mouse_left.stop()
		mouse_left.play()
	if Input.is_action_just_released("mouse_left"):
		mouse_left.stop()
		mouse_unclick.stop()
		mouse_unclick.play()
	
	
func change_state(gd:GDScript):
	state_machine.set_script(gd)
	state_machine.beginning()

'''
func _on_icon_body_entered(body: Node2D) -> void:
	if body != self:return
	is_in_icon = true
	
func _on_icon_body_exited(body: Node2D) -> void:
	if body != self:return
	is_in_icon = false

func _on_window_body_entered(body: Node2D) -> void:
	if body != self:return
	is_on_window = true
	
func _on_window_body_exited(body: Node2D) -> void:
	if body != self:return
	is_on_window = false
'''
