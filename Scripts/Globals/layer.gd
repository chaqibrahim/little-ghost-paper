#layer.gd
extends Node2D
class_name Layer

enum LayerList {
	BACKGROUND,
	MENU,
	SCREEN
}

var layer_list := {}

var background_layer :Control
var menu_layer :Control
var screen_layer :Control

func _ready() -> void:
	await get_tree().create_timer(0.1).timeout
	setup_dictionaries()

func setup_dictionaries() -> void:
	layer_list = {
		LayerList.BACKGROUND : background_layer,
		LayerList.MENU : menu_layer,
		LayerList.SCREEN : screen_layer
	}

func clear_layer(layer:LayerList) -> void:
	if not layer_list.has(layer):
		push_warning("[LAYER] Layer key not found")
		return
	
	var clearing_layer :Control= layer_list[layer]
	for child in clearing_layer.get_children():
		child.queue_free()
