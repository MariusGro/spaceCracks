extends Spaceship

class_name Enemy


func custom_process(_delta: float) -> void:
	if fire_cooldown.is_stopped():
		fire()
