class_name Game
#game.gd
extends Node2D

enum StageList {
	STAGE_1,
	STAGE_2,
	STAGE_3,
	STAGE_4,
	STAGE_5,
}
enum AttackList {
	TUTORIAL,
	BOSS,
}

var need_attack_tutorial := true
var need_defend_tutorial := true
var murderer := false
var stage_list := { }
var attack_list := { }
var controllable := false
var battle_map: Control
var player_health := 100
var player_max_health := 100
var opponent_health := 100
var opponent_max_health := 100
var saved_health := 100


func _ready() -> void:
	await get_tree().create_timer(0.1).timeout
	setup_dictionaries()
	print("[GAME] Ready")


func setup_dictionaries() -> void:
	stage_list = {
		StageList.STAGE_1: Globals.reference.stage1_scene,
		StageList.STAGE_2: Globals.reference.stage2_scene,
		StageList.STAGE_3: Globals.reference.stage3_scene,
		StageList.STAGE_4: Globals.reference.stage4_scene,
		StageList.STAGE_5: Globals.reference.stage5_scene,
	}
	attack_list = {
		AttackList.TUTORIAL: Globals.reference.tutorial_attack,
		AttackList.BOSS: Globals.reference.boss_attack,
	}


func show_stage(stage: StageList) -> void:
	if not stage_list.has(stage):
		push_warning("[STAGE] Stage key not found")
		return

	var new_stage: Node2D = stage_list[stage].instantiate()
	Globals.effect.pixelate_effect.pixelate()
	await get_tree().create_timer(0.5).timeout
	Globals.layer.clear_layer(Layer.LayerList.MENU)
	Globals.layer.clear_layer(Layer.LayerList.STAGE)
	Globals.layer.clear_layer(Layer.LayerList.CHARACTER)
	Globals.layer.stage_layer.add_child(new_stage)
	Globals.effect.pixelate_effect.unpixelate()


func initiate_battle(opponent: AttackList) -> void:
	Globals.effect.pixelate_effect.pixelate()
	await get_tree().create_timer(0.5).timeout
	var battle_ring: Control = Globals.reference.battle_map.instantiate()
	battle_ring.opponent_attack = opponent
	Globals.layer.stage_layer.add_child(battle_ring)
	Globals.effect.pixelate_effect.unpixelate()
	Globals.effect.show_effect(
		Effect.EffectList.WARP,
		Effect.EffectLayer.FRONT,
		Globals.reference.screen_center,
		0.0,
	)
	battle_map = battle_ring
