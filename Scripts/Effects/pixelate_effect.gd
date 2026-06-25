class_name Pixelate
#pixelate_effect.gd
extends ColorRect


func _ready() -> void:
	Globals.effect.pixelate_effect = self


func pixelate() -> void:
	var tween := create_tween()
	tween.tween_property(material, "shader_parameter/pixel_size", 64.0, 0.5)


func unpixelate() -> void:
	var tween := create_tween()
	tween.tween_property(material, "shader_parameter/pixel_size", 1.0, 0.5)
