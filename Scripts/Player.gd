extends Spaceship

class_name Player

@export var speed: int = 100
@export var acceleration: float = 8.0
@export var friction: float = 5.0

signal triggerShake(intensity: float)


func custom_physics_process(delta: float) -> void:
	var input: Vector2 = Input.get_vector("left", "right", "up", "down").normalized()
	var velocity_weight: float = delta * (acceleration if input else friction)
	velocity = lerp(velocity, input * speed, velocity_weight)
	
	if Input.is_action_pressed("fire") and fire_cooldown.is_stopped():
		fire_cooldown.start()
		fire()


func custom_damage_behavior(damage: int) -> void:
	emit_signal("triggerShake", damage)
