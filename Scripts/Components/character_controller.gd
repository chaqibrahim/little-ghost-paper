#character_controller.gd
extends Node

const MOVEMENT_SPEED := 100.0

@onready var parent: RigidBody2D = get_parent()


func _physics_process(_delta: float) -> void:
	if not Globals.game.controllable:
		return

	var direction := Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1

	if direction.length() > 0:
		direction = direction.normalized()

	parent.apply_force(direction * MOVEMENT_SPEED)
