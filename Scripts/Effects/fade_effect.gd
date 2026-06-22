class_name Fade
#fade_effect.gd
extends ColorRect


func _ready() -> void:
	Globals.effect.fade_effect = self


func fade() -> void:
	var tween := create_tween()
	tween.tween_property(self, "color", Color.BLACK, 0.5)


func unfade() -> void:
	var tween := create_tween()
	tween.tween_property(self, "color", Color.TRANSPARENT, 0.5)
