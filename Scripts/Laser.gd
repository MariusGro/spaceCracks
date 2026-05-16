extends Entity

class_name Laser

var speed: int = 500

func setup(pos: Vector2, direction: Vector2, sp: int, allegiance: String) -> void:
	self.position = pos
	self.speed = sp
	self.add_to_group(allegiance)
	self.velocity = Vector2(direction.x * speed, direction.y * speed)

func _physics_process(_delta: float) -> void:
	move_and_slide()

func _on_presence_screen_exited() -> void:
	queue_free()

func setSprite(tex: Texture2D) -> void:
	$Sprite.texture = tex
