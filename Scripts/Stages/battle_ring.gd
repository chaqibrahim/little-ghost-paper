#battle_ring.gd
extends Control

const PLAYER_DAMAGE := 33
const ENEMY_DAMAGE := 20


func _ready() -> void:
	Globals.signalbus.player_attacked.connect(start_qte)
	Globals.signalbus.player_succeed.connect(player_succeed)
	Globals.signalbus.player_failed.connect(player_failed)


func start_qte() -> void:
	var qte := Globals.reference.qte_scene.instantiate()
	add_child(qte)


func player_succeed() -> void:
	Globals.game.opponent_health -= PLAYER_DAMAGE


func enemy_succeed() -> void:
	Globals.game.player_health -= ENEMY_DAMAGE


func player_failed() -> void:
	pass


func enemy_failed() -> void:
	pass
