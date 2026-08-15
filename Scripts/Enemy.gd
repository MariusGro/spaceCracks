extends Spaceship

class_name Enemy


enum EnemyMode {
	IDLE,
	RIGHT_LEFT,
	RANDOM_POINT,
	CHASE,
}


@export var enemy_mode = EnemyMode.IDLE
@export var fire_enabled: bool = true
@export var patrol_radius: int = 100
@export var target_offset: Vector2 = Vector2.ZERO


var enemy_behavior: Callable
var target_point: Vector2 = Vector2.ZERO
var target_direction: Vector2 = Vector2.ZERO

var origin_position: Vector2 = Vector2.ZERO

func custom_ready_behavior() -> void:
	origin_position = position
	match enemy_mode:
		EnemyMode.IDLE:
			enemy_behavior = Callable(EnemyAI, "idle")
		EnemyMode.RIGHT_LEFT:
			enemy_behavior = Callable(EnemyAI, "right_left") # here
			set_target_point(origin_position + Vector2(patrol_radius, 0.0))
		EnemyMode.RANDOM_POINT:
			enemy_behavior = Callable(EnemyAI, "random_point")
			set_random_target()
		EnemyMode.CHASE:
			enemy_behavior = Callable(EnemyAI, "chase")
	#print(name + " has the enemy mode " + EnemyMode.keys()[enemy_mode])


func custom_process(_delta: float) -> void:
	enemy_behavior.call(self)
	if fire_cooldown.is_stopped() and fire_enabled:
		fire()


func custom_damage_behavior(damage: int) -> void:
	var damage_intensity: float = float(damage) / float(max_health)
	Input.start_joy_vibration(0, damage_intensity, 0.0, 0.1)


func set_target_point(point: Vector2):
	target_point = point
	target_direction = target_point - position
	target_direction = target_direction.normalized() * speed
	velocity = target_direction


func get_player_position() -> Vector2:
	return %Player.position


func set_random_target():
	var radius: int = patrol_radius
	set_target_point(
		Vector2(origin_position.x + randi_range(-radius, radius),
		origin_position.y + randi_range(-radius, radius))
	)
