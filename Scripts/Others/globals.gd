#globals.gd
extends Node2D
class_name Singleton
#buat function dan referensi yang dipakai secara global

enum MenuList {
	DISCLAIMER,
	MAIN_MENU
}

enum LayerList {
	BACKGROUND,
	MENU,
	SCREEN
}

@export_group("Menu Scenes")
@export var menu_disclaimer :PackedScene
@export var menu_mainmenu :PackedScene

#dictionaries
var menu_list := {}
var layer_list := {}

#layer reference
var background_layer :Control
var menu_layer :Control
var screen_layer :Control

#referensi lain
var pixelate_effect :Pixelate

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	#otomatisasi settings buat semua node
	get_tree().node_added.connect(on_node_added)
	
	await get_tree().create_timer(0.1).timeout
	setup_dictionaries()
	print("[GLOBAL] Ready")

func setup_dictionaries() -> void:
	menu_list = {
		MenuList.DISCLAIMER : menu_disclaimer,
		MenuList.MAIN_MENU : menu_mainmenu
	}
	
	layer_list = {
		LayerList.BACKGROUND : background_layer,
		LayerList.MENU : menu_layer,
		LayerList.SCREEN : screen_layer
	}

func on_node_added(node:Node) -> void:
	if node is Control:
		control_added(node)
	if node is Button:
		button_added(node)

func control_added(control:Control) -> void:
	#global control settings
	control.pivot_offset_ratio = Vector2(0.5,0.5)
	control.offset_transform_enabled = true
	
	#kasih animasi tiap control muncul
	var tween := create_tween()
	tween.tween_property(control,"offset_transform_scale", Vector2(1.25,1.25), 0.25)
	tween.tween_property(control,"offset_transform_scale", Vector2.ONE, 0.25)
	
	#kasih animasi tiap control select/unselect
	control.focus_entered.connect(control_focus_entered.bind(control))
	control.focus_exited.connect(control_focus_exited.bind(control))

func button_added(button:Button) -> void:
	button.mouse_entered.connect(button_mouse_entered.bind(button))

func control_focus_entered(control:Control) -> void:
	var tween := create_tween()
	tween.tween_property(control,"offset_transform_scale", Vector2(1.5,1.5), 0.25)
	tween.tween_property(control,"offset_transform_scale", Vector2(1.25,1.25), 0.25)

func control_focus_exited(control:Control) -> void:
	var tween := create_tween()
	tween.tween_property(control,"offset_transform_scale", Vector2.ONE, 0.25)

func button_mouse_entered(button:Button) -> void:
	button.grab_focus()

func clear_layer(layer:LayerList) -> void:
	if not layer_list.has(layer):
		push_warning("[GLOBAL] Layer key not found")
		return
	
	var clearing_layer :Control= layer_list[layer]
	for child in clearing_layer.get_children():
		child.queue_free()

func show_menu(menu:MenuList) -> void:
	if not menu_list.has(menu):
		push_warning("[GLOBAL] Menu key not found")
		return
	
	var new_menu :Control= menu_list[menu].instantiate()
	pixelate_effect.pixelate()
	await get_tree().create_timer(0.5).timeout
	clear_layer(LayerList.MENU)
	menu_layer.add_child(new_menu)
	pixelate_effect.unpixelate()
	
