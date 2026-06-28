#opponent_attack_timer.gd
extends Control

const ATTACK_TIME := 10.0

var time := ATTACK_TIME


func _process(delta: float) -> void:
	time = move_toward(time, 0.0, delta)
