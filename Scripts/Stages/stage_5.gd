#stage_5.gd
extends Node2D

var player: Node2D
var boss: Node2D

@onready var boss_pre_pos: Marker2D = $TileMapLayer/BossPrePos
@onready var boss_pos: Marker2D = $TileMapLayer/BossPos
@onready var player_pre_pos: Marker2D = $TileMapLayer/PlayerPrePos
@onready var player_pos: Marker2D = $TileMapLayer/PlayerPos
@onready var spawn_pos: Marker2D = $TileMapLayer/SpawnPos


func _ready() -> void:
	Globals.spawn.spawn_character(Spawn.SpawnList.BOSS, spawn_pos.global_position, 0.0)
	await get_tree().create_timer(0.5).timeout
	boss = get_tree().get_first_node_in_group("boss")
	var tween := create_tween()
	tween.tween_property(boss, "global_position", boss_pre_pos.global_position, 1.0)
	tween.tween_property(boss, "global_position", boss_pos.global_position, 0.25)
	await tween.finished
	Globals.spawn.spawn_character(Spawn.SpawnList.PLAYER, spawn_pos.global_position, 0.0)
	await get_tree().create_timer(0.5).timeout
	player = get_tree().get_first_node_in_group("player")
	tween = create_tween()
	tween.tween_property(player, "global_position", player_pre_pos.global_position, 1.0)
	tween.tween_property(player, "global_position", player_pos.global_position, 0.25)
	await tween.finished
