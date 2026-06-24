#stage_1.gd
extends Node2D

@onready var player_spawn := $PlayerSpawn
@onready var tutorial_spawn := $TutorialSpawn
@onready var walk_point := $WalkPoint


func _ready() -> void:
	await get_tree().create_timer(1.0).timeout
	Globals.spawn.spawn_character(Spawn.SpawnList.PLAYER, player_spawn.global_position, 0.0)
