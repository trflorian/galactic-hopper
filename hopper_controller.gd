extends RigidBody2D

@export var force_power: float
@onready var particles_fire: GPUParticles2D = %ParticlesFire

func _ready() -> void:
	particles_fire.emitting = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var is_throttling = false
	var offset = 0.0
	if Input.is_action_pressed("throttle_left"):
		is_throttling = true
		offset -= 1
	if Input.is_action_pressed("throttle_right"):
		is_throttling = true
		offset += 1
	
	if is_throttling:
		apply_force(-transform.y * force_power, transform.x * offset * 3)
		
	particles_fire.emitting = is_throttling
