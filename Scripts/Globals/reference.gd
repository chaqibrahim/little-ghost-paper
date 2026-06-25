class_name Reference
#reference.gd
extends Node2D

@export_group("Menu Scenes")
@export var disclaimer_scene: PackedScene
@export var mainmenu_scene: PackedScene
@export_group("Stage Scenes")
@export var stage1_scene: PackedScene
@export var stage2_scene: PackedScene
@export_group("Character Scenes")
@export var player_scene: PackedScene
@export var tutorial_guy_scene: PackedScene
@export_group("Effect Scenes")
@export var warp_effect: PackedScene
@export_group("Others")
@export var position_keeper: PackedScene


func _ready() -> void:
	print("[REFERENCE] Ready")
