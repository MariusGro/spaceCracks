extends TextureProgressBar

class_name HealthBar

func setHealth(health: int, maxHealth: int) -> void:
	self.value = health
	self.max_value = maxHealth
