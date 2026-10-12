extends Button

@onready var quit_visual: AnimatedSprite2D = $"../QuitVisual"

func _on_pressed() -> void:
	get_tree().quit()


func _on_mouse_entered() -> void:
	quit_visual.play("MouseOn")

func _on_mouse_exited() -> void:
	quit_visual.play("default")
