#position_keeper.gd
extends Node

const MOVEMENT_SPEED := 500.0
const MAX_LENGTH := 8.0

var initial_position: Vector2

@onready var parent: RigidBody2D = get_parent()


func _ready() -> void:
	initial_position = parent.global_position


func _physics_process(_delta: float) -> void:
	if not initial_position:
		return

	var current_pos := parent.global_position
	if (current_pos - initial_position).length() < MAX_LENGTH:
		return

	var direction := (initial_position - current_pos).normalized()
	parent.apply_force(direction * MOVEMENT_SPEED)
