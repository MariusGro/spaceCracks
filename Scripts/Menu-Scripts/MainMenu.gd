extends Node

@onready var main_menu_panel: Panel = %MainMenuPanel
@onready var settings: settings_menu = %Settings

func _ready() -> void:
	show_main_menu()
	settings.back_button.connect("pressed", show_main_menu)

func show_main_menu() -> void:
	main_menu_panel.visible = true
	settings.visible = false

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_game.tscn")

func _on_settings_pressed() -> void:
	main_menu_panel.visible = false
	settings.visible = true

func _on_exit_pressed() -> void:
	get_tree().quit()
