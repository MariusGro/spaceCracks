extends Spaceship

class_name Enemy


enum EnemyMode {
	IDLE,
	FIRE,
}


@export var enemy_mode = EnemyMode.IDLE


func custom_ready_behavior() -> void:
	print(name + " has the enemy mode " + EnemyMode.keys()[enemy_mode])


func custom_process(_delta: float) -> void:
	if fire_cooldown.is_stopped():
		fire()
