#sprite_normalizer.gd
extends Node

enum Direction {
	LEFT,
	RIGHT,
}

const ROTATION_SPEED := 720.0

var last_direction := Direction.RIGHT

@onready var parent: RigidBody2D = get_parent()


func _physics_process(_delta: float) -> void:
	if parent.global_rotation == 0.0:
		return

	var torque_to_apply := -parent.global_rotation - parent.angular_velocity
	parent.apply_torque(torque_to_apply * ROTATION_SPEED)
	#parent.global_rotation = move_toward(parent.global_rotation, 0.0, delta)
