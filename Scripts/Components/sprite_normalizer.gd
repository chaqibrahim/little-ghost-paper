#sprite_normalizer.gd
extends Node

const ROTATION_SPEED := 1800.0

var sprite: Sprite2D

@onready var parent: RigidBody2D = get_parent()


func _ready() -> void:
	for child in parent.get_children():
		if child is Sprite2D:
			sprite = child
			break


func _process(_delta: float) -> void:
	if not sprite:
		return
	if parent.linear_velocity.x > 0:
		if sprite.flip_h:
			sprite.flip_h = false
	elif parent.linear_velocity.x < 0:
		if not sprite.flip_h:
			sprite.flip_h = true


func _physics_process(_delta: float) -> void:
	if parent.global_rotation == 0.0:
		return

	var torque_to_apply := -parent.global_rotation #- parent.angular_velocity
	parent.apply_torque(torque_to_apply * ROTATION_SPEED)
	#parent.global_rotation = move_toward(parent.global_rotation, 0.0, delta)
