class_name Game
#game.gd
extends Node2D

enum StageList {
	STAGE_1,
}

var stage_list := { }


func _ready() -> void:
	await get_tree().create_timer(0.1).timeout
	setup_dictionaries()
	print("[GAME] Ready")


func setup_dictionaries() -> void:
	stage_list = {
		StageList.STAGE_1: Globals.reference.stage1_scene,
	}


func show_stage(stage: StageList) -> void:
	if not stage_list.has(stage):
		push_warning("[STAGE] Stage key not found")
		return

	var new_stage: Node2D = stage_list[stage].instantiate()
	Globals.effect.pixelate_effect.pixelate()
	await get_tree().create_timer(0.5).timeout
	Globals.layer.clear_layer(Layer.LayerList.STAGE)
	Globals.layer.stage_layer.add_child(new_stage)
	Globals.effect.pixelate_effect.unpixelate()
