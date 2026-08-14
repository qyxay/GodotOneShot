extends Area2D

# 节点引用
@onready var back_light: Sprite2D = $BackLight
@onready var icon_sprite: Sprite2D = $Icon
@onready var icon_copy: Sprite2D = $IconCopy
@onready var back_light_copy: Sprite2D = $BackLightCopy
var mouse:CharacterBody2D

# 状态节点引用
@onready var state_idle: IconStateBase = $IdleNode
@onready var state_hover: IconStateBase = $HoverNode
@onready var state_drag: IconStateBase = $DragNode

var current_state: IconStateBase = null

# 导出变量
@export var icon_name:String = "文档"

@export var texture: Texture2D:
	set(new_tex):
		_texture_cache = new_tex
	get:
		return _texture_cache

var _texture_cache: Texture2D

# 拖拽缓存数据
var drag_offset: Vector2
var start_global_pos: Vector2
var press_mouse_pos: Vector2


func _ready():
	modulate = Preload.theme_color
	if _texture_cache:
		icon_sprite.texture = _texture_cache
		icon_copy.texture = _texture_cache

	var all_icons:Array[Node] = get_tree().get_nodes_in_group("icon_group")
	for _icon in all_icons:
		_icon.position = round_pos(_icon.position)
	Preload.refresh_map()

	mouse = get_tree().root.get_node("Windows/Mouse")
	get_node("Label").text = icon_name

	# 注入宿主引用给所有状态
	state_idle.host = self
	state_hover.host = self
	state_drag.host = self

	# 初始进入 idle
	switch_state(state_idle)


# 核心状态切换函数
func switch_state(new_state: IconStateBase):
	if current_state == new_state: return
	if current_state: 
		current_state.exit()
	current_state = new_state
	current_state.enter()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_left"):
		if current_state == state_hover and mouse.is_in_icon:
			press_mouse_pos = mouse.global_position
			switch_state(state_drag)

	if event.is_action_released("mouse_left"):
		if current_state == state_drag:
			if mouse.is_in_icon:
				switch_state(state_hover)
			else:
				switch_state(state_idle)


func _physics_process(_delta: float) -> void:
	if current_state != null:
		current_state.physics_update(_delta)

# Area2D 碰撞信号
func _on_body_entered(body: Node2D) -> void:
	if body != mouse: return
	if current_state == state_idle:
		switch_state(state_hover)

func _on_body_exited(body: Node2D) -> void:
	if body != mouse: return
	if current_state == state_hover:
		switch_state(state_idle)


# 工具函数
func round_pos(pos:Vector2):
	var snap_x:float = clamp(round(pos.x / 300) * 300 + 100, -800, 700)
	var snap_y:float = clamp(round(pos.y / 200) * 200, -400, 200)
	var snap_pos:Vector2 = Vector2(snap_x, snap_y)
	return snap_pos

func set_all_opacity(alpha: float):
	var children:Array[Node] = get_children()
	for child:Node in children:
		if child is CanvasItem:
			var col:Color = child.self_modulate
			col.a = clamp(alpha, 0.0, 1.0)
			child.self_modulate = col
