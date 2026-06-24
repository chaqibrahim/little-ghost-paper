class_name Effect
#effect.gd
extends Node2D

enum EffectList {
	WARP,
}
enum EffectLayer {
	FRONT,
	BACK,
}

var pixelate_effect: Pixelate
var fade_effect: Fade
var effect_list := { }
var effect_layer := { }


func _ready() -> void:
	await get_tree().create_timer(0.1).timeout
	setup_dictionaries()
	print("[EFFECT] Ready")


func setup_dictionaries() -> void:
	effect_list = {
		EffectList.WARP: Globals.reference.warp_effect,
	}

	effect_layer = {
		EffectLayer.FRONT: Globals.layer.front_layer,
		EffectLayer.BACK: Globals.layer.back_layer,
	}


func show_effect(effect: EffectList, layer: EffectLayer, pos: Vector2, rot: float) -> void:
	if not effect_list.has(effect):
		push_warning("[EFFECT] Effect key not found")
		return

	if not effect_layer.has(layer):
		push_warning("[EFFECT] Effect layer not found")
		return

	var new_effect: Node2D = effect_list[effect].instantiate()
	var new_effect_layer: Control = effect_layer[layer]
	new_effect.global_position = pos
	new_effect.global_rotation = rot
	new_effect_layer.add_child(new_effect)


func chat_animation_effect(chatter: Node2D) -> void:
	var tween := create_tween()
	var initial_position := chatter.global_position
	var adjusted_position := chatter.global_position + Vector2(0.0, 8.0)
	tween.tween_property(chatter, "global_position", adjusted_position, 0.125)
	tween.tween_property(chatter, "global_position", initial_position, 0.125)
