extends Node

class_name EnemyAI


static func idle(enemy: Enemy) -> void:
	if enemy.fire_cooldown.is_stopped() and enemy.fire_enabled:
		enemy.fire()
