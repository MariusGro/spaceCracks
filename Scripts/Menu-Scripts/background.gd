extends TextureRect

var shader_material: ShaderMaterial

func _ready() -> void:
	shader_material = material as ShaderMaterial

func _on_pause_menu_pause_mode_changed(mode: float) -> void:
	shader_material.set_shader_parameter("shader_process", mode)
