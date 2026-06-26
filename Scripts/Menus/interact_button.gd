#interact_button.gd
extends Control


func _ready() -> void:
	Globals.signalbus.interaction_shown.connect(show)
	Globals.signalbus.interaction_hidden.connect(hide)
