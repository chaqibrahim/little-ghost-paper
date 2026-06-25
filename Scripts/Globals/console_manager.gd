#console_manager.gd
extends Node


func _ready() -> void:
	LimboConsole.register_command(show_stage)


func show_stage(stage: Game.StageList) -> void:
	Globals.game.show_stage(stage)
