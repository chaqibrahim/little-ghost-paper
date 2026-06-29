class_name Spawn
#spawn.gd
extends Node2D

enum SpawnList {
	PLAYER,
	TUTORIAL_GUY,
	WALL,
	TUTORIAL_DEAD,
}

var spawn_list := { }


func _ready() -> void:
	await get_tree().create_timer(0.1).timeout
	setup_dictionaries()
	print("[SPAWN] Ready")


func setup_dictionaries() -> void:
	spawn_list = {
		SpawnList.PLAYER: Globals.reference.player_scene,
		SpawnList.TUTORIAL_GUY: Globals.reference.tutorial_guy_scene,
		SpawnList.WALL: Globals.reference.wall_scene,
		SpawnList.TUTORIAL_DEAD: Globals.reference.tutorial_dead,
	}


func spawn_character(character: SpawnList, pos: Vector2, rot: float) -> void:
	if not spawn_list.has(character):
		push_warning("[SPAWN] Spawn key not found")
		return

	Globals.effect.show_effect(Effect.EffectList.WARP, Effect.EffectLayer.FRONT, pos, rot)
	await get_tree().create_timer(0.25).timeout
	var new_character: Node2D = spawn_list[character].instantiate()
	new_character.global_position = pos
	new_character.global_rotation = rot
	Globals.layer.character_layer.add_child(new_character)
