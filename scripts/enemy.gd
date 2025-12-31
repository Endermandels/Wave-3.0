extends CharacterBody2D
class_name Enemy

@export_group("Internal Nodes")
@export var motor_cmp: MotorComponent

@export_group("Resources")
@export var enemy_stats: EnemyStats

func _ready() -> void:
    _load_stats()
    motor_cmp.init_velocity(self)

func physics_update(delta: float) -> void:
    motor_cmp.handle_movement(self, delta)

func _load_stats() -> void:
    if not enemy_stats:
        push_warning("[%s] Missing Enemy Stats" % self.name)
        return
    
    motor_cmp.speed = enemy_stats.speed
    motor_cmp.acceleration = enemy_stats.acceleration