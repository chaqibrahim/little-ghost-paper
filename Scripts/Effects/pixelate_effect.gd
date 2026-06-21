#pixelate_effect.gd
extends ColorRect
class_name Pixelate

func _ready() -> void:
	Globals.pixelate_effect = self

func pixelate() -> void:
	var tween := create_tween()
	tween.tween_property(material, "shader_parameter/pixel_size", 64.0, 0.5)

func unpixelate() -> void:
	var tween := create_tween()
	tween.tween_property(material, "shader_parameter/pixel_size", 1.0, 0.5)
