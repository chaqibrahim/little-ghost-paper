class_name Reference
#reference.gd
extends Node2D

@export_group("Menu Scenes")
@export var disclaimer_scene: PackedScene
@export var mainmenu_scene: PackedScene
@export_group("Stage Scenes")
@export var stage1_scene: PackedScene


func _ready() -> void:
	print("[REFERENCE] Ready")
