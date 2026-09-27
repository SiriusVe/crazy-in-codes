extends CanvasLayer

@onready var pause_button: Button = $PauseButton
@onready var panel: Panel = $Panel

func _on_pause_button_pressed() -> void:
	get_tree().paused = true
	panel.visible = true

func _on_continue_pressed() -> void:
	panel.visible = false
	get_tree().paused = false


func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_back_to_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Crazy in Codes.tscn")
