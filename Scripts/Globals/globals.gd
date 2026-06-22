#globals.gd
extends Node2D
class_name Singleton



@onready var reference :Reference= $Reference
@onready var layer :Layer= $Layer
@onready var menu :Menu= $Menu
@onready var effect :Effect= $Effect

func _ready() -> void:
	print("[GLOBAL] Ready")


	
