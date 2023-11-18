extends Node2D

@export var world_limit_x: float
@export var cloud_start_y: float
@export var world_limit_y: float

@export var scale_min: float
@export var scale_max: float

@export var clouds_cnt: int
@export var clouds_scenes: Array[Texture2D]

func _ready():
	for i in range(clouds_cnt):
		var tex = clouds_scenes.pick_random()
		var inst_scale = randf_range(scale_min, scale_max)
		
		var inst = Sprite2D.new()
		inst.texture = tex
		#inst.modulate = Color("59a253")
		inst.scale = Vector2.ONE * inst_scale
		inst.position = Vector2(randf_range(-world_limit_x, world_limit_x), -randf_range(cloud_start_y, world_limit_y))
		add_child(inst)
