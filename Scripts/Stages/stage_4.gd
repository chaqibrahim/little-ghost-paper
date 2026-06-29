#stage_4.gd
extends Node2D

@export var dialogue: DialogueResource

var player: Node2D
var boss: Node2D

@onready var tutorial_guy := $TutorialGuy
@onready var spawn_position := $PlayerSpawn
@onready var player_pos := $PlayerPos
@onready var player_pre_pos := $PlayerPrePos
@onready var tutorial_pos := $TutorialPos
@onready var boss_spawn := $BossSpawn
@onready var boss_walk := $BossWalk


func _ready() -> void:
	Globals.signalbus.dialogue1_finished.connect(keep_attack)
	Globals.signalbus.dialogue2_finished.connect(end_battle)
	Globals.signalbus.dialogue3_finished.connect(murderer_transition)

	Globals.spawn.spawn_character(Spawn.SpawnList.PLAYER, spawn_position.global_position, 0.0)
	await get_tree().create_timer(0.5).timeout
	player = get_tree().get_first_node_in_group("player")
	var tweeen := create_tween()
	tweeen.tween_property(tutorial_guy, "global_position", tutorial_pos.global_position, 0.25)
	tweeen.tween_property(player, "global_position", player_pos.global_position, 1.0)
	await tweeen.finished
	DialogueManager.show_dialogue_balloon(dialogue, "start")


func keep_attack() -> void:
	#animasi attack tutorial guy terus mati
	var tween := create_tween()
	tween.tween_property(player, "global_position", tutorial_pos.global_position, 0.25)
	tutorial_guy.queue_free()
	Globals.spawn.spawn_character(
		Spawn.SpawnList.TUTORIAL_DEAD,
		tutorial_pos.global_position,
		deg_to_rad(90.0),
	)
	tween.tween_property(player, "global_position", player_pre_pos.global_position, 0.25)
	tween.tween_property(player, "global_position", player_pos.global_position, 0.25)
	await tween.finished
	tween.stop()

	#muncul bystander jadi saksi
	Globals.spawn.spawn_character(Spawn.SpawnList.BOSS, boss_spawn.global_position, 0.0)
	await get_tree().create_timer(0.5).timeout
	boss = get_tree().get_first_node_in_group("boss")
	tween.tween_property(boss, "global_position", boss_walk.global_position, 0.5)
	tween.play()


func end_battle() -> void:
	pass


func murderer_transition() -> void:
	var tween := create_tween()
	tween.tween_property(boss, "global_position", boss_spawn.global_position, 0.5)
