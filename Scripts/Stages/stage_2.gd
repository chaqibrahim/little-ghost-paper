#stage_2.gd
extends Node2D

@export var dialogue: DialogueResource

var player: Node2D
var tutorial_guy: Node2D

@onready var player_spawn := $PlayerSpawn
@onready var tutorial_spawn := $TutorialSpawn
@onready var player_walkpoint := $WalkPointPlayer
@onready var tutorial_walkpoint := $WalkPointTutorial


func _ready() -> void:
	walk_in()


func walk_in() -> void:
	Globals.spawn.spawn_character(Spawn.SpawnList.PLAYER, player_spawn.global_position, 0.0)
	Globals.spawn.spawn_character(Spawn.SpawnList.TUTORIAL_GUY, tutorial_spawn.global_position, 0.0)
	await get_tree().create_timer(0.5).timeout
	player = get_tree().get_first_node_in_group("player")
	tutorial_guy = get_tree().get_first_node_in_group("tutorial_guy")

	var tween := create_tween()
	tween.set_parallel(true)
	tween.tween_property(tutorial_guy, "global_position", tutorial_walkpoint.global_position, 2.0)
	tween.tween_property(player, "global_position", player_walkpoint.global_position, 2.0)
	await tween.finished
	DialogueManager.show_dialogue_balloon(dialogue, "start")
