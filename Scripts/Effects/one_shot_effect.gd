class_name OneShotEffect
#one_shot_effect.gd
extends GPUParticles2D


func _ready() -> void:
	finished.connect(queue_free)
