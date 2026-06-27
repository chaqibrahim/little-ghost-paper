#battle_ui.gd
extends Control

@onready var player_health := $YouHealth
@onready var opponent_health := $OpponentHealth


func _process(_delta: float) -> void:
	if player_health.max_value != Globals.game.player_max_health:
		player_health.max_value = Globals.game.player_max_health

	if player_health.value != Globals.game.player_health:
		player_health.value = Globals.game.player_health

	if opponent_health.max_value != Globals.game.opponent_max_health:
		opponent_health.max_value = Globals.game.opponent_max_health

	if opponent_health.value != Globals.game.opponent_health:
		opponent_health.value = Globals.game.opponent_health
