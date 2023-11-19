extends RigidBody2D

@export var force_power: float
@export var rotate_power: float
@export var max_rotational_offset: float

@export var particles_explosion: PackedScene
@export var parts_explosion: PackedScene

@onready var particles_fire: GPUParticles2D = %ParticlesFire
@onready var audio_engine: AudioStreamPlayer2D = %AudioEngine

var rotational_offset: float = 0.0
var is_audio_playing: bool = false

func _ready() -> void:
	particles_fire.emitting = false
	
	body_entered.connect(_on_collison)

func _process(_delta: float) -> void:
	var is_throttling = false
	if Input.is_action_pressed("throttle_right"):
		is_throttling = true
		rotational_offset -= 1
	if Input.is_action_pressed("throttle_left"):
		is_throttling = true
		rotational_offset += 1
	
	rotational_offset = clampf(rotational_offset, -max_rotational_offset, max_rotational_offset)
	
	if is_throttling:
		apply_force(-transform.y * force_power, transform.x * rotational_offset * rotate_power)
		if not is_audio_playing:
			is_audio_playing = true
			audio_engine.play()
	else:
		is_audio_playing = false
		audio_engine.stop()
		rotational_offset = 0.0
		
	#audio_engine.playing = is_throttling
	particles_fire.emitting = is_throttling
		
	rotational_offset *= 0.9

func _on_collison(body: Node) -> void:
	print("body = ", body)
	print("velocity = ",  round(linear_velocity.length()))
	print("rotation = ",  round(abs(rotation_degrees)))
	
	var max_velocity = 2
	if abs(rotation_degrees) < 20:
		max_velocity = 200
	if linear_velocity.length() > max_velocity:
		_explode(global_position)

func _explode(point: Vector2) -> void:
	var explosion = particles_explosion.instantiate()
	explosion.position = point
	explosion.rotation = global_rotation
	explosion.emitting = true
	get_tree().current_scene.add_child(explosion)
	
	var parts = parts_explosion.instantiate()
	parts.position = point
	parts.rotation = global_rotation
	get_tree().current_scene.add_child(parts)
	
	queue_free()
