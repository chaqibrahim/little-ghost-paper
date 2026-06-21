#globals.gd
extends Node2D

var menu_layer :Control

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	get_tree().node_added.connect(on_node_added)

func on_node_added(node:Node) -> void:
	if node is Control:
		node.pivot_offset_ratio = Vector2(0.5,0.5)
		node.offset_transform_enabled = true
		node.focus_entered.connect(control_focus_entered.bind(node))
		node.focus_exited.connect(control_focus_exited.bind(node))
	if node is Button:
		node.mouse_entered.connect(button_mouse_entered.bind(node))

func control_focus_entered(control:Control) -> void:
	var tween := create_tween()
	tween.tween_property(control,"offset_transform_scale", Vector2(1.5,1.5), 0.25)
	tween.tween_property(control,"offset_transform_scale", Vector2(1.25,1.25), 0.25)

func control_focus_exited(control:Control) -> void:
	var tween := create_tween()
	tween.tween_property(control,"offset_transform_scale", Vector2.ONE, 0.25)

func button_mouse_entered(button:Button) -> void:
	button.grab_focus()
