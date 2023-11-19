extends Camera2D

@export var target_node: Node2D

func _process(_delta: float) -> void:
	if target_node != null:
		global_position = target_node.global_position
