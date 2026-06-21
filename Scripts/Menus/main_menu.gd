#main_menu.gd
extends Control

@onready var play_button := $VBoxContainer/PlayButton
@onready var quit_button := $VBoxContainer/QuitButton

func _ready() -> void:
	play_button.pressed.connect(play_pressed)
	quit_button.pressed.connect(quit_pressed)

func play_pressed() -> void:
	pass

func quit_pressed() -> void:
	get_tree().quit()
