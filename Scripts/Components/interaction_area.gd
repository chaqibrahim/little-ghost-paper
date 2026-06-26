#interaction_area.gd
extends Area2D


func _ready() -> void:
	body_entered.connect(entered_interaction)
	body_exited.connect(exited_interaction)


func entered_interaction(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return
	Globals.menu.interaction_button.show()


func exited_interaction(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return
	Globals.menu.interaction_button.hide()
