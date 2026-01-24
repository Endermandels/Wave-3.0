extends Node
class_name MovementComponent

const DELTA_SCALE: float = 60.0 ## Basically FPS

@export_group("Settings")
@export_range(0, 1) var acceleration: float = 0.2
@export var speed: float = 300.0
@export var start_speed: float = 0.0 ## Speed at spawn
@export var can_bounce: bool = true
@export var motor: bool = false ## When selected, this component acts as a motor
@export_subgroup("Gravity")
@export var gravity_enable: bool = false
@export var gravity_dir: Vector2 = Vector2.DOWN
@export var gravity_acceleration: float = 10.0

var collision_info: KinematicCollision2D = null
var motor_dir: Vector2 = Vector2.ZERO
var gravity_spd: float = 0.0

func init_velocity(body: CharacterBody2D, dir: Vector2) -> void:
	body.velocity = dir * start_speed
	motor_dir = dir

func handle_motor_movement(body: CharacterBody2D, delta: float) -> void:
	assert(motor, "Motor must be enabled to handle motor movement")
	handle_movement(body, motor_dir, delta)

func handle_movement(body: CharacterBody2D, dir: Vector2, delta: float) -> void:
	# Acceleration
	var target_velocity = dir * speed
	if gravity_enable:
		if gravity_dir.y != 0:
			target_velocity.y += gravity_dir.y * gravity_spd
		elif gravity_dir.x != 0:
			target_velocity.x += gravity_dir.x * gravity_spd
		gravity_spd += gravity_acceleration * delta * DELTA_SCALE
	body.velocity = body.velocity.lerp(target_velocity, acceleration * delta * DELTA_SCALE)

	# Movement
	collision_info = body.move_and_collide(body.velocity * delta)

	# Collision
	if collision_info and can_bounce:
		body.velocity = body.velocity.bounce(collision_info.get_normal())
		motor_dir = body.velocity.normalized()

		# Set gravity to 0 on hitting the floor
		if collision_info.get_normal().dot(gravity_dir) < -0.9:
			gravity_spd = 0
