#sprite_normalizer.gd
extends Node

const ROTATION_SPEED := 1800.0

var sprite: Sprite2D
var last_position: Vector2

@onready var parent: Node2D = get_parent()


func _ready() -> void:
	last_position = parent.global_position
	for child in parent.get_children():
		if child is Sprite2D:
			sprite = child
			break


func _process(delta: float) -> void:
	if not sprite:
		return
	if not last_position:
		return
	var velocity := (parent.global_position - last_position) / delta
	if velocity.x > 0.0:
		sprite.flip_h = false
	elif velocity.x < -0.0:
		sprite.flip_h = true
	last_position = parent.global_position


func _physics_process(_delta: float) -> void:
	if not parent is RigidBody2D:
		return
	if parent.global_rotation == 0.0:
		return

	var torque_to_apply := -parent.global_rotation #- parent.angular_velocity
	parent.apply_torque(torque_to_apply * ROTATION_SPEED)
	#parent.global_rotation = move_toward(parent.global_rotation, 0.0, delta)
