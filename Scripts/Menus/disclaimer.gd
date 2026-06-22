#disclaimer.gd
extends Control

var can_continue := false
var tween: Tween

@onready var disclaimer := $Label


func _ready() -> void:
    tween = create_tween()
    tween.tween_property(disclaimer, "visible_ratio", 1.0, 10.0)
    await tween.finished
    can_continue = true


func _input(event: InputEvent) -> void:
    if event.is_action_pressed("ui_accept"):
        if not can_continue:
            tween.kill()
            disclaimer.visible_ratio = 1.0
            can_continue = true
        else:
            Globals.menu.show_menu(Menu.MenuList.MAIN_MENU)
