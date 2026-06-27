#battle_ring.gd
extends Control

const PLAYER_DAMAGE := 33
const ENEMY_DAMAGE := 20

@export var dialogue: DialogueResource

var player: Node2D
var opponent: Node2D

@onready var center := $Center
@onready var player_pos := $PlayerPos
@onready var opponent_pos := $OpponentPos


func _ready() -> void:
	Globals.signalbus.player_attacked.connect(start_qte)
	Globals.signalbus.player_succeed.connect(player_succeed)
	Globals.signalbus.player_failed.connect(player_failed)

	player = get_tree().get_first_node_in_group("player")
	opponent = get_tree().get_first_node_in_group("opponent")


func start_qte() -> void:
	var qte: Control = Globals.reference.qte_scene.instantiate()
	add_child(qte)


func player_succeed() -> void:
	var tween := create_tween()
	tween.tween_property(player, "global_position", opponent_pos.global_position, 0.25)
	Globals.effect.show_effect(
		Effect.EffectList.WARP,
		Effect.EffectLayer.FRONT,
		opponent_pos.global_position,
		0.0,
	)
	tween.tween_property(player, "global_position", player_pos.global_position, 0.25)
	await tween.finished
	Globals.game.opponent_health -= PLAYER_DAMAGE
	DialogueManager.show_dialogue_balloon(dialogue, "opponent_turn")


func enemy_succeed() -> void:
	Globals.game.player_health -= ENEMY_DAMAGE


func player_failed() -> void:
	pass


func enemy_failed() -> void:
	pass
