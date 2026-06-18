extends CanvasLayer

class_name settings_menu

@onready var back_button: Button = %"Back Button"
@onready var fullscreen_checkbox: CheckBox = $"SettingsPanel/MarginContainer/VBoxContainer/Fullscreen Checkbox"

func _ready() -> void:
	if DisplayServer.window_get_mode() == DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN:
		fullscreen_checkbox.button_pressed = true
	else:
		fullscreen_checkbox.button_pressed = false

func _on_fullscreen_checkbox_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
