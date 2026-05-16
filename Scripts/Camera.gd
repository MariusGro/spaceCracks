extends Camera2D

const SHAKE_DECAY_RATE: float = 5.0

@onready var rand = RandomNumberGenerator.new()

var shake_strength: float = 0.0

func _ready() -> void:
	rand.randomize()
	get_parent().connect("triggerShake", apply_shake)

func apply_shake(intensity: float) -> void:
	shake_strength = intensity

func _process(delta: float) -> void:
	shake_strength = lerp(shake_strength, 0.0, SHAKE_DECAY_RATE * delta)
	
	offset = get_random_offset()

func get_random_offset() -> Vector2:
	return Vector2(
		rand.randf_range(-shake_strength, shake_strength),
		rand.randf_range(-shake_strength, shake_strength)
	)
