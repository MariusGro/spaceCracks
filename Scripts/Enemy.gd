extends Entity

class_name Enemy

const PROJECTILE: PackedScene = preload("res://Scenes/laser.tscn")
const LASER_GREEN_PARTICLE: Texture2D = preload("uid://bnoglvimt7psx")
const PROJECTILE_ALLEGIANCE: String = "Enemy_projectile"
const PROJECTILE_DIRECTION: Vector2 = Vector2(0.0, 1.0)
const PROJECTILE_SPEED: int = 50
const PROJECTILE_Y_ALIGNMENT: float = 11.0

var maxHealth: int = 10
var health: int = 10

@onready var health_bar: HealthBar = $"Health Bar"

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("fire"):
		fire()
	updateHealthBar()

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("Player_projectile"):
		health -= 1
		flash_red(1, 0.05)
		area.get_parent().queue_free() # TODO

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
	laser.setup(
		Vector2(position.x, position.y + PROJECTILE_Y_ALIGNMENT),
		PROJECTILE_DIRECTION,
		PROJECTILE_SPEED,
		PROJECTILE_ALLEGIANCE,
		LASER_GREEN_PARTICLE
	)
	get_parent().add_child(laser)

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
