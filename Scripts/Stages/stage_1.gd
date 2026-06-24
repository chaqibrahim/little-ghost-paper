#stage_1.gd
extends Node2D

@export var dialogue1: DialogueResource

@onready var player_spawn := $PlayerSpawn
@onready var tutorial_spawn := $TutorialSpawn
@onready var walk_point := $WalkPoint


func _ready() -> void:
	play_opening()


func play_opening() -> void:
	await get_tree().create_timer(1.0).timeout
	Globals.spawn.spawn_character(Spawn.SpawnList.PLAYER, player_spawn.global_position, 0.0)
	await get_tree().create_timer(1.0).timeout
	DialogueManager.show_dialogue_balloon(dialogue1, "opening")
