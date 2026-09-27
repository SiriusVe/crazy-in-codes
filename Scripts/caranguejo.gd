extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

const SPEED = 70.0
var direction = 1
var live:bool = true

func _ready():
	 
	animated_sprite_2d.play("Andando")

func _physics_process(delta: float) -> void:
	if live == true:
		velocity.x = direction * SPEED
		move_and_slide()
		
		
		if is_on_wall():
			direction *= -1
			animated_sprite_2d.flip_h = direction < 0
		

# teste colisão e animação
#func _on_area_2d_body_entered(body: Node2D) -> void:
	#print("Detectou: ", body.name)
#
	#if body.is_in_group("inimigos"):
		#print("Inimigo!")
		#live = false
		#animated_sprite_2d.play("Morrendo")
