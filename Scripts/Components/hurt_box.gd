#hurt_box.gd
extends Area2D


func _ready() -> void:
	body_entered.connect(hurt)


func hurt(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return

	Globals.signalbus.enemy_succeed.emit()
