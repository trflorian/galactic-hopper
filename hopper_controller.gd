extends RigidBody2D

@export var force_power: float
@export var rotate_power: float
@export var max_rotational_offset: float

@onready var particles_fire: GPUParticles2D = %ParticlesFire
@onready var audio_engine: AudioStreamPlayer2D = %AudioEngine

var rotational_offset: float = 0.0

func _ready() -> void:
	particles_fire.emitting = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
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
		if not audio_engine.playing:
			audio_engine.play()
	else:
		audio_engine.stop()
		rotational_offset = 0.0
		
	#audio_engine.playing = is_throttling
	particles_fire.emitting = is_throttling
		
	rotational_offset *= 0.98
