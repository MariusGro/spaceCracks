extends Spaceship

class_name Player

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
	var damage_intensity: float = float(damage) / float(max_health)
	Input.start_joy_vibration(0, 0.0, damage_intensity * 2, damage_intensity)
	if health <= 0:
		call_deferred("load_game_over_screen") # Because some physics-processes may still run

func load_game_over_screen():
	get_tree().change_scene_to_file("res://Scenes/Menus/game_over_screen.tscn")
