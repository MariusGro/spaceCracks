extends Node

class_name EnemyAI


static func idle(_enemy: Enemy) -> void: # Supressed warning
	pass


static func right_left(enemy: Enemy) -> void:
	if enemy.position.distance_to(enemy.target_point) < 3: # A little threshold
		var direction: int = 1
		if enemy.position.x > enemy.origin_position.x:
			direction *= -1
		enemy.set_target_point(enemy.origin_position + direction * Vector2(enemy.patrol_radius, 0))
		#print(enemy.target_point)


static func chase(enemy: Enemy) -> void:
	if enemy.position.distance_to(enemy.get_player_position()) <= enemy.patrol_radius:
		enemy.set_target_point(enemy.get_player_position() + enemy.target_offset)
	else:
		enemy.set_target_point(enemy.origin_position)
	if enemy.position.distance_to(enemy.target_point) < 3:
		enemy.velocity = Vector2.ZERO


static func random_point(enemy: Enemy) -> void:
	if enemy.position.distance_to(enemy.target_point) < 3:
		enemy.set_random_target()
