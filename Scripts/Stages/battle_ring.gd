#battle_ring.gd
extends Control

const PLAYER_DAMAGE := 33
const ENEMY_DAMAGE := 20

@export var dialogue: DialogueResource

var player: Node2D
var opponent: Node2D
var opponent_attack: Game.AttackList

@onready var center := $Center
@onready var player_pre_pos := $PlayerPrePos
@onready var player_pos := $PlayerPos
@onready var opponent_pos := $OpponentPos
@onready var dodge_pos := $DodgePos


func _ready() -> void:
	Globals.signalbus.player_attacked.connect(start_qte)
	Globals.signalbus.player_succeed.connect(player_succeed)
	Globals.signalbus.player_failed.connect(player_failed)
	Globals.signalbus.enemy_attacked.connect(start_dodging)
	Globals.signalbus.enemy_succeed.connect(enemy_succeed)
	Globals.signalbus.enemy_failed.connect(enemy_failed)
	Globals.signalbus.battle_ended.connect(queue_free)

	player = get_tree().get_first_node_in_group("player")
	opponent = get_tree().get_first_node_in_group("opponent")


func start_qte() -> void:
	var qte: Control = Globals.reference.qte_scene.instantiate()
	add_child(qte)


func start_dodging() -> void:
	Globals.game.controllable = true
	var opponent_attack_time: OpponentAttack = Globals.reference.opponent_attack.instantiate()
	opponent_attack_time.opponent = opponent_attack
	add_child(opponent_attack_time)


func player_succeed() -> void:
	var tween := create_tween()
	tween.tween_property(player, "global_position", opponent_pos.global_position, 0.25)
	Globals.effect.show_effect(
		Effect.EffectList.WARP,
		Effect.EffectLayer.FRONT,
		opponent_pos.global_position,
		0.0,
	)
	tween.tween_property(player, "global_position", player_pre_pos.global_position, 0.25)
	tween.tween_property(player, "global_position", player_pos.global_position, 0.25)
	await tween.finished
	Globals.game.opponent_health -= PLAYER_DAMAGE
	DialogueManager.show_dialogue_balloon(dialogue, "opponent_turn")


func enemy_succeed() -> void:
	Globals.game.controllable = false
	Globals.game.player_health -= ENEMY_DAMAGE
	Globals.effect.show_effect(
		Effect.EffectList.WARP,
		Effect.EffectLayer.FRONT,
		player.global_position,
		0.0,
	)
	var tween := create_tween()
	tween.tween_property(player, "global_position", player_pre_pos.global_position, 0.25)
	tween.tween_property(player, "global_position", player_pos.global_position, 0.25)
	tween.parallel().tween_property(opponent, "global_position", opponent_pos.global_position, 0.25)
	DialogueManager.show_dialogue_balloon(dialogue, "my_turn")


func player_failed() -> void:
	var tween := create_tween()
	tween.tween_property(player, "global_position", opponent_pos.global_position, 0.25)
	tween.parallel().tween_property(opponent, "global_position", dodge_pos.global_position, 0.25)
	tween.tween_property(player, "global_position", player_pre_pos.global_position, 0.25)
	tween.tween_property(player, "global_position", player_pos.global_position, 0.25)
	tween.parallel().tween_property(opponent, "global_position", opponent_pos.global_position, 0.25)
	await tween.finished
	DialogueManager.show_dialogue_balloon(dialogue, "opponent_turn")


func enemy_failed() -> void:
	Globals.game.controllable = false
	var tween := create_tween()
	tween.tween_property(player, "global_position", player_pre_pos.global_position, 0.25)
	tween.tween_property(player, "global_position", player_pos.global_position, 0.25)
	tween.parallel().tween_property(opponent, "global_position", opponent_pos.global_position, 0.25)
	DialogueManager.show_dialogue_balloon(dialogue, "my_turn")
