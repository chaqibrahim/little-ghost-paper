#main.gd
extends Control


func _ready() -> void:
	Globals.layer.background_layer = $BackgroundLayer
	Globals.layer.stage_layer = $StageLayer
	Globals.layer.back_layer = $BackLayer
	Globals.layer.character_layer = $CharacterLayer
	Globals.layer.front_layer = $FrontLayer
	Globals.layer.menu_layer = $MenuLayer
	Globals.layer.screen_layer = $ScreenLayer

	await get_tree().create_timer(1.0).timeout
	Globals.menu.show_menu(Menu.MenuList.DISCLAIMER)
