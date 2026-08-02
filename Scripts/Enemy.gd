extends Spaceship

class_name Enemy


enum EnemyMode {
	IDLE,
}


@export var enemy_mode = EnemyMode.IDLE

@export var fire_enabled: bool = true

## Determines how far the enemy will move away from it's original position if the EnemyMode makes the enemy move in a continous pattern.
@export var patrol_radius: int = 100

var enemy_behavior: Callable


func custom_ready_behavior() -> void:
	match enemy_mode:
		EnemyMode.IDLE:
			enemy_behavior = Callable(EnemyAI, "idle")
	print(name + " has the enemy mode " + EnemyMode.keys()[enemy_mode])


func custom_process(_delta: float) -> void:
	enemy_behavior.call(self)
