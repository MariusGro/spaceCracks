extends Entity

class_name Spaceship

const PROJECTILE: PackedScene = preload("res://Scenes/laser.tscn")

@export var max_health: int = 10
@export var projectile_speed: int = 50
@export var projectile_sprite: Texture2D = preload("res://Art/laser_empty_particle.png")
@export var projectile_group: String = "None"
@export var projectile_x_correction: int = 0
@export var projectile_y_correction: int = 0
@export var projectile_direction: Vector2 = Vector2.ZERO
@export var damage_color: Color = Color.WHITE
@export var harmful_groups: Dictionary[String, int] = {}

@onready var health_bar: HealthBar = $"Health Bar"
@onready var fire_cooldown: Timer = $"Fire Cooldown"

var health: int = 1


func _ready() -> void:
	health = max_health


func _process(delta: float) -> void:
	update_health_bar()
	custom_process(delta)


func _physics_process(delta: float) -> void:
	move_and_slide()
	custom_physics_process(delta)


## Is called by the default [method Node._process]-method.
## Used to add content from inheriting classes to the main-loop.
func custom_process(_delta: float) -> void:
	pass


## Is called by the default [method Node._physics_process]-method
## Used to add content from inheriting classes to the main-physics-loop.
func custom_physics_process(_delta: float) -> void:
	pass


func update_health_bar() -> void:
	if health != max_health:
		health_bar.visible = true
		health_bar.setHealth(health, max_health)
		if health <= 0:
			print(name + " has been defeated")
			queue_free()
	else:
		health_bar.visible = false


func fire() -> void:
	var laser: Laser = PROJECTILE.instantiate() as Laser
	laser.setup(
		Vector2(
			position.x + projectile_x_correction,
			position.y + projectile_y_correction
		),
		projectile_direction,
		projectile_speed,
		projectile_group,
		projectile_sprite
	)
	get_parent().add_child(laser)
	
	fire_cooldown.start()


## Clanker code
func flash(times: int, flash_time: float, color: Color) -> void:
	var tween = create_tween()
	tween.set_parallel(false)
	
	for i in times:
		tween.tween_property(
			$Sprite,
			"modulate",
			color,
			flash_time
		)
		tween.tween_property(
			$Sprite,
			"modulate",
			Color.WHITE,
			flash_time
		)


## Called automatically when the [Spaceship] loses health inside of the
## [method Spaceship._on_hitbox_area_entered]-method.
func custom_damage_behavior(_damage: int) -> void:
		pass


func _on_hitbox_area_entered(area: Area2D) -> void:
	for damage_type: String in harmful_groups.keys():
		if area.get_parent().is_in_group(damage_type):
			if area.get_parent().is_in_group("Projectile"):
				area.get_parent().queue_free()
			var damage: int = harmful_groups[damage_type]
			health -= damage
			flash(damage, 0.05, damage_color)
			custom_damage_behavior(damage)
