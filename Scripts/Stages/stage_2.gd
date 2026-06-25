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
	pass
