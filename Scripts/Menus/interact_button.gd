#interact_button.gd
extends Control


func _ready() -> void:
	Globals.menu.interaction_button = self
	visibility_changed.connect(show_hide)


func show_hide() -> void:
	if visible:
		Globals.menu.interaction_ready = true
	else:
		Globals.menu.interaction_ready = false
