extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer

const SPEED = 100.0
var direction = 1

func _ready() -> void:
	animated_sprite_2d.play("Voando")

func _physics_process(delta: float) -> void:
	velocity.x = direction * SPEED
	move_and_slide()
	
func _on_timer_timeout() -> void:
	direction = direction * -1
	animated_sprite_2d.flip_h = direction < 0
	timer.start()
