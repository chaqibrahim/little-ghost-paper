#main.gd
extends Control

func _ready() -> void:
	Globals.background_layer = $BackgroundLayer
	Globals.menu_layer = $MenuLayer
	Globals.screen_layer = $ScreenLayer
	
	await get_tree().create_timer(1.0).timeout
	Globals.show_menu(Globals.MenuList.DISCLAIMER)
