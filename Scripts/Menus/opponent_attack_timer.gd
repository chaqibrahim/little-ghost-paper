class_name OpponentAttack
#opponent_attack_timer.gd
extends Control

const ATTACK_TIME := 10.0

var time := ATTACK_TIME
var opponent: Game.AttackList
var opponent_char: Node2D

@onready var timer_right := $AttackTimerRight
@onready var timer_left := $AttackTimerLeft
@onready var corner_1: Marker2D = $Corner1
@onready var corner_2: Marker2D = $Corner2
@onready var corner_3: Marker2D = $Corner3
@onready var corner_4: Marker2D = $Corner4
@onready var spawn_spots := [corner_1, corner_2, corner_3, corner_4]


func _ready() -> void:
	Globals.signalbus.enemy_failed.connect(queue_free)
	Globals.signalbus.enemy_succeed.connect(queue_free)

	opponent_char = get_tree().get_first_node_in_group("opponent")
	opponent_char.hide()
	opponent_char.process_mode = Node.PROCESS_MODE_DISABLED

	var attack: Node2D = Globals.game.attack_list[opponent].instantiate()
	var spawn: Marker2D = spawn_spots.pick_random()
	attack.global_position = spawn.global_position
	add_child(attack)


func _process(delta: float) -> void:
	time = move_toward(time, 0.0, delta)

	if time == 0.0:
		Globals.signalbus.enemy_failed.emit()

	timer_right.value = time * 10
	timer_left.value = time * 10


func _exit_tree() -> void:
	opponent_char.show()
	opponent_char.process_mode = Node.PROCESS_MODE_INHERIT
