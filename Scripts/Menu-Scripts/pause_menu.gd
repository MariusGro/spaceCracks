extends CanvasLayer

@onready var settings: settings_menu = $"Settings Menu"
@onready var pause_title: RichTextLabel = $PauseTitle
@onready var pause_menu_panel: Panel = $PauseMenuPanel

signal pause_mode_changed(mode: float)

func _ready() -> void:
	set_pause_menu_visibility(false)
	settings.back_button.connect("pressed", toggle_settings_menu_visibility)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause") and settings.visible == false:
		set_pause(!get_tree().paused)

func set_pause(value: bool):
	get_tree().paused = value
	set_pause_menu_visibility(value)
	

func set_pause_menu_visibility(value: bool):
	pause_title.visible = value
	pause_menu_panel.visible = value

func toggle_settings_menu_visibility():
	settings.visible = !settings.visible
	pause_menu_panel.visible = !pause_menu_panel.visible

func _on_continue_pressed() -> void:
	set_pause(false)

func _on_settings_pressed() -> void:
	toggle_settings_menu_visibility()

func _on_title_screen_pressed() -> void:
	set_pause(false)
	get_tree().change_scene_to_file("res://Scenes/Menus/main_menu.tscn")
