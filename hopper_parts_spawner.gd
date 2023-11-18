extends Node2D

@export var parts: Array[Texture2D]
@export var part_prefab: PackedScene

func _ready() -> void:
	for p in parts:
		var inst: RigidBody2D = part_prefab.instantiate()
		var sp = inst.find_child("Sprite")
		sp.texture = p
		
		inst.apply_impulse(Vector2.from_angle(randf_range(-PI, PI)) * 800)
		#inst.apply_torque_impulse(randf_range(-1.0, 1.0) * 1000)
		
		add_child(inst)
