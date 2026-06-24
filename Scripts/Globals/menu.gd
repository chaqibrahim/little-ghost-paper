class_name Menu
#menu.gd
extends Node2D

enum MenuList {
	DISCLAIMER,
	MAIN_MENU,
}

var menu_list := { }


func _ready() -> void:
	get_tree().node_added.connect(on_node_added)
	await get_tree().create_timer(0.1).timeout
	setup_dictionaries()
	print("[MENU] Ready")


func setup_dictionaries() -> void:
	menu_list = {
		MenuList.DISCLAIMER: Globals.reference.disclaimer_scene,
		MenuList.MAIN_MENU: Globals.reference.mainmenu_scene,
	}


func on_node_added(node: Node) -> void:
	#biar otomatis tiap munculin menu
	if node is Control:
		control_added(node)
	if node is Button:
		button_added(node)


func control_added(control: Control) -> void:
	#global menu settings
	control.pivot_offset_ratio = Vector2(0.5, 0.5)
	control.offset_transform_enabled = true

	#kasih animasi tiap menu muncul
	var tween := create_tween()
	tween.tween_property(control, "offset_transform_scale", Vector2(1.25, 1.25), 0.25)
	tween.tween_property(control, "offset_transform_scale", Vector2.ONE, 0.25)

	#kasih animasi tiap menu select/unselect
	control.focus_entered.connect(control_focus_entered.bind(control))
	#control.focus_exited.connect(control_focus_exited.bind(control))


func button_added(button: Button) -> void:
	button.mouse_entered.connect(button_mouse_entered.bind(button))
	button.pressed.connect(button_pressed.bind(button))


func control_focus_entered(control: Control) -> void:
	var tween := create_tween()
	tween.tween_property(control, "offset_transform_scale", Vector2(1.5, 1.5), 0.125)
	tween.tween_property(control, "offset_transform_scale", Vector2.ONE, 0.125)


func control_focus_exited(control: Control) -> void:
	var tween := create_tween()
	tween.tween_property(control, "offset_transform_scale", Vector2.ONE, 0.25)


func button_mouse_entered(button: Button) -> void:
	button.grab_focus()


func button_pressed(button: Button) -> void:
	var tween := create_tween()
	tween.tween_property(button, "offset_transform_scale", Vector2(1.25, 1.25), 0.125)
	tween.tween_property(button, "offset_transform_scale", Vector2.ONE, 0.125)


func show_menu(menu: MenuList) -> void:
	if not menu_list.has(menu):
		push_warning("[MENU] Menu key not found")
		return

	var new_menu: Control = menu_list[menu].instantiate()
	Globals.effect.pixelate_effect.pixelate()
	await get_tree().create_timer(0.5).timeout
	Globals.layer.clear_layer(Layer.LayerList.MENU)
	Globals.layer.menu_layer.add_child(new_menu)
	Globals.effect.pixelate_effect.unpixelate()
