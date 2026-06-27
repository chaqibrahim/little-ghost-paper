#qte_bar.gd
extends Control

const MAX_HIT := 62.5
const MIN_HIT := 37.5
const MAX_AIM := 100.0
const MIN_AIM := 0.0
const AIM_SPEED := 100.0
const POS_ADJUSTER := Vector2(5.0, 10.0)

var aim := 0.0
var direction := 1.0

@onready var trigger: ColorRect = $Trigger
@onready var left: Marker2D = $Left
@onready var right: Marker2D = $Right


func _process(delta: float) -> void:
	if direction == 1.0:
		aim = move_toward(aim, MAX_AIM, delta * AIM_SPEED)
		if aim >= 100.0:
			direction = -1.0

	elif direction == -1.0:
		aim = move_toward(aim, MIN_AIM, delta * AIM_SPEED)
		if aim <= 0.0:
			direction = 1.0

	var progress := aim / 100.0
	trigger.global_position = left.global_position.lerp(
		right.global_position,
		progress,
	) - POS_ADJUSTER


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		if aim >= MIN_HIT and aim <= MAX_HIT:
			Globals.signalbus.player_succeed.emit()
		else:
			Globals.signalbus.player_failed.emit()
		queue_free()
