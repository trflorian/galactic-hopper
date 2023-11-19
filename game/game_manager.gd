extends Node2D

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("reset"):
		_reload_scene()

func start_reset_scene_timer() -> void:
	var timer = get_tree().create_timer(2)
	timer.timeout.connect(_reload_scene)

func _reload_scene() -> void:
	get_tree().reload_current_scene()
