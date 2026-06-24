class_name Singleton
#globals.gd
extends Node2D

@onready var reference: Reference = $Reference
@onready var layer: Layer = $Layer
@onready var menu: Menu = $Menu
@onready var effect: Effect = $Effect
@onready var game: Game = $Game
@onready var spawn: Spawn = $Spawn


func _ready() -> void:
	print("[GLOBAL] Ready")
