#boss_projectile.gd
extends Node2D

const PROJECTILE_SPEED := 25.0

var projectile_duration := 5.0


func _physics_process(delta: float) -> void:
	global_position += Vector2(0.0, -1.0) * delta * PROJECTILE_SPEED

	projectile_duration = move_toward(projectile_duration, 0.0, delta)
	if projectile_duration == 0.0:
		queue_free()
