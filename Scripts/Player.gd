extends Entity

class_name Player

const SPEED: int = 100
const ACCELERATION: float = 8
const FRICTION: float = 5

const PROJECTILE: PackedScene = preload("res://Scenes/laser.tscn")
const PROJECTILE_ALLEGIANCE: String = "Player_projectile"
const PROJECTILE_DIRECTION: Vector2 = Vector2(0.0, -1.0)
const PROJECTILE_SPEED: int = 500
const LASER_RED_PARTICLE = preload("uid://d3c2oinumpdh0")

@onready var fire_cooldown: Timer = $"Fire Cooldown"
@onready var health_bar: HealthBar = $"Health Bar"

signal triggerShake(intensity: float)

var maxHealth: int = 10
var health: int = 10

func _physics_process(delta: float) -> void:
	var input: Vector2 = Input.get_vector("left", "right", "up", "down").normalized()
	var velocity_weight: float = delta * (ACCELERATION if input else FRICTION)
	velocity = lerp(velocity, input * SPEED, velocity_weight)
	
	if Input.is_action_pressed("fire") and fire_cooldown.is_stopped():
		fire_cooldown.start()
		fire()
	
	updateHealthBar()
	
	move_and_slide()

func updateHealthBar() -> void:
	if health != maxHealth:
		health_bar.visible = true
		health_bar.setHealth(health, maxHealth)
		if health <= 0:
			print(name + " has been defeated")
			queue_free()
	else:
		health_bar.visible = false

func fire() -> void:
	var laser = PROJECTILE.instantiate() as Laser
	laser.setup(position, PROJECTILE_DIRECTION, PROJECTILE_SPEED, PROJECTILE_ALLEGIANCE, LASER_RED_PARTICLE)
	get_parent().add_child(laser)

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("Enemy_projectile"):
		health -= 1
		flash_red(1, 0.05)
		emit_signal("triggerShake", 2.0)
		area.get_parent().queue_free() # TODO
	elif area.get_parent().is_in_group("Enemy"):
		health -= 3
		flash_red(3, 0.05)
		emit_signal("triggerShake", 5.0)
		# Do not delete the Enemy!

# Clanker code
func flash_red(times: int, flash_time: float):
	var tween := create_tween()
	tween.set_parallel(false)
	
	for i in times:
		tween.tween_property(
			$Sprite,
			"modulate",
			Color("e64539"),
			flash_time
		)
		tween.tween_property(
			$Sprite,
			"modulate",
			Color.WHITE,
			flash_time
		)
