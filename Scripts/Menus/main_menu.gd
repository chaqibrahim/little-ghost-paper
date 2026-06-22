#main_menu.gd
extends Control

@onready var play_button := $VBoxContainer/PlayButton
@onready var quit_button := $VBoxContainer/QuitButton


func _ready() -> void:
	play_button.pressed.connect(play_pressed)
	quit_button.pressed.connect(quit_pressed)

	await get_tree().create_timer(0.25).timeout
	play_button.grab_focus()


func play_pressed() -> void:
	Globals.game.show_stage(Game.StageList.STAGE_1)
	Globals.layer.clear_layer(Layer.LayerList.MENU)


func quit_pressed() -> void:
	get_tree().quit()
