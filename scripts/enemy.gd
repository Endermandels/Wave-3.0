extends CharacterBody2D
class_name Enemy

@export_group("Internal Nodes")
@export var motor_cmp: MotorComponent
@export var enable_collision_timer: Timer
@export var collision_shape: CollisionShape2D

@export_group("Resources")
@export var enemy_stats: EnemyStats

func _ready() -> void:
	_load_stats()
	collision_shape.disabled = true
	motor_cmp.init_velocity(self)

func update() -> void:
	if collision_shape.disabled and enable_collision_timer.is_stopped():
		collision_shape.disabled = false

func physics_update(delta: float) -> void:
	motor_cmp.handle_movement(self, delta)

func _load_stats() -> void:
	if not enemy_stats:
		push_warning("[%s] Missing Enemy Stats" % self.name)
		return
	
	motor_cmp.speed = enemy_stats.speed
	motor_cmp.acceleration = enemy_stats.acceleration
