#boss_attack.gd
extends Node2D

const ATTACK_INTERVAL := 1.0

var attack_time := ATTACK_INTERVAL
var player: RigidBody2D

@onready var parent: OpponentAttack = get_parent()


func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")


func _process(delta: float) -> void:
	attack_time = move_toward(attack_time, 0.0, delta)

	if attack_time == 0.0:
		attack()
		attack_time = ATTACK_INTERVAL

	if player:
		global_position = global_position.move_toward(player.global_position, delta)


func attack() -> void:
	var target := player.global_position
	var projectile: Node2D = Globals.reference.boss_projectile.instantiate()
	projectile.global_position = global_position
	projectile.look_at(target)
	projectile.global_rotation += deg_to_rad(90)
	parent.add_child(projectile)
