class_name DialogueAnimator
#dialogue_animator.gd
extends Node

@onready var parent: Node2D = get_parent()


func _ready() -> void:
	if parent.is_in_group("player"):
		Globals.signalbus.player_talked.connect(animate_dialogue)
	elif parent.is_in_group("tutorial_guy"):
		Globals.signalbus.tutorial_guy_talked.connect(animate_dialogue)


func animate_dialogue() -> void:
	var tween := create_tween()
	var initial_position := parent.global_position
	var adjusted_position := parent.global_position + Vector2(0.0, -8.0)
	tween.tween_property(parent, "global_position", adjusted_position, 0.125)
	tween.tween_property(parent, "global_position", initial_position, 0.125)
