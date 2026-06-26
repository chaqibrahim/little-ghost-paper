#stage_2.gd
extends Node2D

@export var dialogue: DialogueResource

var player: Node2D
var tutorial_guy: Node2D
var interaction_ready := false
var proceed_ready := false

@onready var player_spawn := $PlayerSpawn
@onready var tutorial_spawn := $TutorialSpawn
@onready var player_walkpoint := $WalkPointPlayer
@onready var tutorial_walkpoint := $WalkPointTutorial
@onready var tutorial_walkpoint2 := $WalkPointTutorial2
@onready var tutorial_walkpoint3 := $WalkPointTutorial3
@onready var tutorial_walkpoint4 := $WalkPointTutorial4
@onready var interation_area := $InteractionArea
@onready var border_area := $Border


func _ready() -> void:
	interation_area.body_entered.connect(entered_tutorial_interaction)
	interation_area.body_exited.connect(exited_tutorial_interaction)
	border_area.body_entered.connect(entered_border)
	Globals.signalbus.dialogue1_finished.connect(correct_player)
	walk_in()


func _input(event: InputEvent) -> void:
	if not interaction_ready:
		return
	if event.is_action_pressed("ui_accept"):
		proceed()


func correct_player() -> void:
	var tween := create_tween()
	tween.tween_property(player, "global_position", tutorial_walkpoint3.global_position, 0.25)


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
	var pos_keep: Node = Globals.reference.position_keeper.instantiate()
	tutorial_guy.add_child(pos_keep)


func entered_tutorial_interaction(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return
	Globals.signalbus.interaction_shown.emit()
	interaction_ready = true


func exited_tutorial_interaction(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return
	Globals.signalbus.interaction_hidden.emit()
	interaction_ready = false


func entered_border(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return
	if proceed_ready:
		return
	DialogueManager.show_dialogue_balloon(dialogue, "border")


func proceed() -> void:
	DialogueManager.show_dialogue_balloon(dialogue, "proceed")
