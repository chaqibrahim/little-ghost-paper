#main_menu.gd
extends Control

@onready var play_button := $VBoxContainer/PlayButton
@onready var quit_button := $VBoxContainer/QuitButton

func _ready() -> void:
	play_button.pressed.connect(play_pressed)
	quit_button.pressed.connect(quit_pressed)
	
	play_button.grab_focus()

func play_pressed() -> void:
	pass

func quit_pressed() -> void:
	get_tree().quit()
