extends Node
class_name MovementComponent

@export_group("Settings")
@export var acceleration: float = 0.2
@export var speed: float = 200

func handle_movement(body: CharacterBody2D, dir: Vector2):
	body.velocity = body.velocity.lerp(dir * speed, acceleration)
