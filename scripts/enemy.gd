extends CharacterBody2D
class_name Enemy

@export_group("Internal Nodes")
@export var movement_cmp: MovementComponent
@export var enable_collision_timer: Timer
@export var collision_shape: CollisionShape2D
@export var wall_collision_sfx: AudioStreamPlayer2D
@export var hitbox_cmp: HitboxComponent

@export_group("Resources")
@export var enemy_stats: EnemyStats

func _ready() -> void:
	_load_stats()
	collision_shape.disabled = true
	movement_cmp.init_velocity(self)

func update() -> void:
	if collision_shape.disabled and enable_collision_timer.is_stopped():
		collision_shape.disabled = false

func physics_update(delta: float) -> void:
	movement_cmp.handle_motor_movement(self, delta)
	if movement_cmp.collision_info and not wall_collision_sfx.playing:
		wall_collision_sfx.pitch_scale = randf_range(0.8, 1.2)
		wall_collision_sfx.play()

func _load_stats() -> void:
	if not enemy_stats:
		push_warning("[%s] Missing Enemy Stats" % self.name)
		return
	
	movement_cmp.start_speed = enemy_stats.start_speed
	movement_cmp.speed = enemy_stats.speed
	movement_cmp.acceleration = enemy_stats.acceleration
	hitbox_cmp.dmg = enemy_stats.dmg
