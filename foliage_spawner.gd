extends Node2D

@export var world_limit: float = 8000.0

@export var scale_min: float
@export var scale_max: float

@export var foliage_cnt: int
@export var foliage_scenes: Array[Texture2D]

func _ready():
	for i in range(foliage_cnt):
		var tex = foliage_scenes.pick_random()
		var inst_scale = randf_range(scale_min, scale_max)
		
		var inst = Sprite2D.new()
		inst.texture = tex
		inst.modulate = Color("59a253")
		inst.scale = Vector2.ONE * inst_scale
		inst.position = Vector2(randf_range(-world_limit, world_limit), -tex.get_size().y * inst_scale * 0.5)
		add_child(inst)
