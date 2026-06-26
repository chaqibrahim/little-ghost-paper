#stage_3.gd
extends Node2D

@export var dialogue: DialogueResource

var player: Node2D

@onready var spawn_position := $SpawnPos
@onready var walk_position := $WalkPos
@onready var barrier_position1 := $BarrierPos1
@onready var barrier_position2 := $BarrierPos2
@onready var dialogue_trigger := $DialogueTrigger
@onready var stage_warp := $StageWarp


func _ready() -> void:
	Globals.spawn.spawn_character(Spawn.SpawnList.PLAYER, spawn_position.global_position, 0.0)
	await get_tree().create_timer(0.5).timeout
	player = get_tree().get_first_node_in_group("player")

	var tween := create_tween()
	tween.tween_property(player, "global_position", walk_position.global_position, 0.5)
	await tween.finished
	Globals.spawn.spawn_character(Spawn.SpawnList.WALL, barrier_position1.global_position, 0.0)
	Globals.spawn.spawn_character(Spawn.SpawnList.WALL, barrier_position2.global_position, 0.0)

	DialogueManager.show_dialogue_balloon(dialogue, "start")
