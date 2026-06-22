#disclaimer.gd
extends Control

var can_continue := false

@onready var disclaimer := $Label

func _ready() -> void:
	var tween := create_tween()
	tween.tween_property(disclaimer, "visible_ratio", 1.0, 10.0)
	await tween.finished
	can_continue = true

func _input(event: InputEvent) -> void:
	if not can_continue:
		return
	if event.is_action_pressed("ui_accept"):
		Globals.menu.show_menu(Menu.MenuList.MAIN_MENU)
