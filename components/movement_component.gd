extends Node
class_name MovementComponent

@export_group("Settings")
@export_range(0, 1) var acceleration: float = 0.2
@export var speed: float = 300.0
@export var start_speed: float = 0.0 ## Speed at spawn
@export var can_bounce: bool = true
@export var motor: bool = false ## When selected, this component acts as a motor

var collision_info: KinematicCollision2D = null

func init_velocity(body: CharacterBody2D, dir: Vector2) -> void:
	body.velocity = dir * start_speed

func handle_motor_movement(body: CharacterBody2D, delta: float) -> void:
	assert(motor, "Motor must be enabled to handle motor movement")
	handle_movement(body, body.velocity.normalized(), delta)

func handle_movement(body: CharacterBody2D, dir: Vector2, delta: float) -> void:
	# Acceleration
	body.velocity = body.velocity.lerp(dir * speed, acceleration)

	# Movement
	collision_info = body.move_and_collide(body.velocity * delta)

	# Collision
	if collision_info and can_bounce:
		body.velocity = body.velocity.bounce(collision_info.get_normal())
