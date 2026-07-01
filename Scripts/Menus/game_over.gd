#game_over.gd
extends Control

@onready var retry_button: Button = $VBoxContainer/RetryButton
@onready var menu_button: Button = $VBoxContainer/MenuButton


func _ready() -> void:
	Globals.layer.clear_layer(Layer.LayerList.STAGE)
	Globals.layer.clear_layer(Layer.LayerList.CHARACTER)
	retry_button.pressed.connect(retry)
	menu_button.pressed.connect(menu)


func retry() -> void:
	Globals.game.show_stage(Game.StageList.STAGE_5)
	Globals.layer.clear_layer(Layer.LayerList.MENU)


func menu() -> void:
	Globals.menu.show_menu(Menu.MenuList.MAIN_MENU)
