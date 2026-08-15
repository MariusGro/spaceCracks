extends CanvasLayer


func _ready() -> void:
	%Retry.grab_focus()


func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_game.tscn")


func _on_title_screen_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menus/main_menu.tscn")
