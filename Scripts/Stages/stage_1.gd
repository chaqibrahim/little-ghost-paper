#stage_1.gd
extends Node2D

@export var dialogue: DialogueResource

var player: Node2D
var tutorial_guy: Node2D

@onready var player_spawn := $PlayerSpawn
@onready var tutorial_spawn := $TutorialSpawn
@onready var walk_point := $WalkPoint


func _ready() -> void:
	play_opening()


func play_opening() -> void:
	Globals.signalbus.dialogue1_finished.connect(play_tutorial_coming)
	await get_tree().create_timer(1.0).timeout
	Globals.spawn.spawn_character(Spawn.SpawnList.PLAYER, player_spawn.global_position, 0.0)
	Globals.spawn.spawn_character(Spawn.SpawnList.TUTORIAL_GUY, tutorial_spawn.global_position, 0.0)
	await get_tree().create_timer(0.5).timeout
	player = get_tree().get_first_node_in_group("player")
	tutorial_guy = get_tree().get_first_node_in_group("tutorial_guy")
	await get_tree().create_timer(0.5).timeout
	DialogueManager.show_dialogue_balloon(dialogue, "opening")


func play_tutorial_coming() -> void:
	Globals.signalbus.dialogue2_finished.connect(move_out)
	var tween := create_tween()
	tween.tween_property(tutorial_guy, "global_position", walk_point.global_position, 1.0)
	await tween.finished
	DialogueManager.show_dialogue_balloon(dialogue, "tutorial_coming")


func move_out() -> void:
	var tween := create_tween()
	tween.set_parallel(true)
	tween.tween_property(tutorial_guy, "global_position", tutorial_spawn.global_position, 1.0)
	tween.tween_property(player, "global_position", tutorial_spawn.global_position, 1.5)
	await tween.finished
	Globals.game.show_stage(Game.StageList.STAGE_2)
