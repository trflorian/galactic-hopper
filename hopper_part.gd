extends RigidBody2D

var time = 0.0

func _process(delta: float) -> void:
	time += delta
	var alpha = 1.0 - time/1.0
	$Sprite.self_modulate.a = maxf(0.0, alpha)
