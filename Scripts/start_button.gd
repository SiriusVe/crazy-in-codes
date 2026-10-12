extends Button

@onready var start_visual: AnimatedSprite2D = $"../StartVisual"

func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/fase_1.tscn")



func _on_mouse_entered() -> void:
	start_visual.play("OnMouse")


func _on_mouse_exited() -> void:
	start_visual.play("default")
