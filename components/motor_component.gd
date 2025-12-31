extends Node
class_name MotorComponent

@export_group("Settings")
@export_range(0, 1) var acceleration: float = 0.2
@export var speed: float = 300
@export var start_speed: float = 300 ## Speed at spawn
@export_range(-180, 180, 1.0, "radians_as_degrees") var initial_rotation: float = 0 ## Rotation from RIGHT (if randomize_dir is false)
@export var randomize_dir: bool = true ## Whether to randomize the initial direction
@export var can_bounce: bool = true

var dir: Vector2 = Vector2.ZERO

func init_velocity(body: CharacterBody2D) -> void:
    if randomize_dir:
        body.velocity = Vector2.RIGHT.rotated(randf_range(0, 2 * PI)) * start_speed
    else:
        body.velocity = Vector2.RIGHT.rotated(deg_to_rad(initial_rotation)) * start_speed

func handle_movement(body: CharacterBody2D, delta: float) -> void:
    # Acceleration
    body.velocity = body.velocity.lerp(body.velocity.normalized() * speed, acceleration)

    # Movement
    var collision_info = body.move_and_collide(body.velocity * delta)
    
    # Collision
    if collision_info and can_bounce:
        body.velocity = body.velocity.bounce(collision_info.get_normal())