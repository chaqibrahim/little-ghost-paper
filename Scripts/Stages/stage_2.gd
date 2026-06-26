#stage_2.gd
extends Node2D

@export var dialogue: DialogueResource

var player: Node2D
var tutorial_guy: Node2D
var proceed_ready := false

@onready var player_spawn := $PlayerSpawn
@onready var tutorial_spawn := $TutorialSpawn
@onready var player_walkpoint := $WalkPointPlayer
@onready var tutorial_walkpoint := $WalkPointTutorial
@onready var tutorial_walkpoint2 := $WalkPointTutorial2
@onready var tutorial_walkpoint3 := $WalkPointTutorial3
@onready var tutorial_walkpoint4 := $WalkPointTutorial4
@onready var barrier_position1 := $BarrierSpawn
@onready var barrier_position2 := $BarrierSpawn2
@onready var border_area := $Border


func _ready() -> void:
	#konekin signal
	border_area.body_entered.connect(entered_border)
	Globals.signalbus.dialogue1_finished.connect(correct_player)
	Globals.signalbus.dialogue2_finished.connect(route_open)

	#mulai stage
	walk_in()


func _input(event: InputEvent) -> void:
	if not Globals.menu.interaction_ready:
		return
	if event.is_action_pressed("ui_accept"):
		proceed()


func correct_player() -> void:
	var tween := create_tween()
	tween.tween_property(player, "global_position", tutorial_walkpoint3.global_position, 0.75)


func walk_in() -> void:
	#spawn karakter
	Globals.spawn.spawn_character(Spawn.SpawnList.PLAYER, player_spawn.global_position, 0.0)
	Globals.spawn.spawn_character(Spawn.SpawnList.TUTORIAL_GUY, tutorial_spawn.global_position, 0.0)
	await get_tree().create_timer(0.5).timeout
	player = get_tree().get_first_node_in_group("player")
	tutorial_guy = get_tree().get_first_node_in_group("tutorial_guy")

	#mereka jalan ke posisi
	var tween := create_tween()
	tween.set_parallel(true)
	tween.tween_property(tutorial_guy, "global_position", tutorial_walkpoint.global_position, 2.0)
	tween.tween_property(player, "global_position", player_walkpoint.global_position, 2.0)
	await tween.finished
	DialogueManager.show_dialogue_balloon(dialogue, "start")
	var pos_keep: Node = Globals.reference.position_keeper.instantiate()
	tutorial_guy.add_child(pos_keep)

	#munculin barrier di belakang
	Globals.spawn.spawn_character(Spawn.SpawnList.WALL, barrier_position1.global_position, 0.0)
	Globals.spawn.spawn_character(Spawn.SpawnList.WALL, barrier_position2.global_position, 0.0)


func entered_border(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return
	if proceed_ready:
		Globals.game.controllable = false
		Globals.game.show_stage(Game.StageList.STAGE_3)
	else:
		DialogueManager.show_dialogue_balloon(dialogue, "border")


func proceed() -> void:
	DialogueManager.show_dialogue_balloon(dialogue, "proceed")


func route_open() -> void:
	var pos_keep: Node
	for child in tutorial_guy.get_children():
		if child.is_in_group("position_keeper"):
			pos_keep = child
			break
	pos_keep.queue_free()
	proceed_ready = true

	#tutorial guy pergi
	var tween := create_tween()
	tween.tween_property(tutorial_guy, "global_position", tutorial_walkpoint2.global_position, 1.0)
	tween.tween_property(tutorial_guy, "global_position", tutorial_walkpoint3.global_position, 0.5)
	tween.tween_property(tutorial_guy, "global_position", tutorial_walkpoint4.global_position, 1.0)
