extends CharacterBody2D
class_name Enemy

const ENEMY_STATS: Array = [
	[0.1, preload("res://resources/enemy_stats/basic_enemy_stats.tres")],
	[0.1, preload("res://resources/enemy_stats/big_enemy_stats.tres")],
	[0.1, preload("res://resources/enemy_stats/fast_enemy_stats.tres")],
	[0.1, preload("res://resources/enemy_stats/poison_enemy_stats.tres")],
	[0.1, preload("res://resources/enemy_stats/tracer_enemy_stats.tres")],
	[0.5, preload("res://resources/enemy_stats/gravity_enemy_stats.tres")],
]

@export_group("Internal Nodes")
@export var color_rect: ColorRect
@export var movement_cmp: MovementComponent
@export var wall_collision_sfx: AudioStreamPlayer2D
@export var hitbox_cmp: HitboxComponent
@export var boundary_detection: Area2D
@export var collision_shape: CollisionShape2D
@export var hitbox_collision_shape: CollisionShape2D
@export var boundary_detection_collision_shape: CollisionShape2D

@export_group("Resources")
@export var enemy_stats: EnemyStats

var boundary_detected = false
var no_boundaries = true

func _ready() -> void:
	_load_stats()
	collision_shape.disabled = true
	movement_cmp.init_velocity(self, self.global_position.direction_to(GameManager.game_state.player_pos))

func update() -> void:
	if collision_shape.disabled:
		if entered_arena():
			collision_shape.disabled = false

func entered_arena() -> bool:
	if boundary_detected and no_boundaries:
		return true

	var bodies = boundary_detection.get_overlapping_bodies()
	no_boundaries = true

	# Collision layer is set to only the boundary bodies
	if bodies.size() > 0:
		no_boundaries = false
		boundary_detected = true

	return false

func physics_update(delta: float) -> void:
	if enemy_stats.follows_player:
		movement_cmp.handle_movement(self, self.global_position.direction_to(GameManager.game_state.player_pos), delta)
	else:
		movement_cmp.handle_motor_movement(self, delta)
	if movement_cmp.collision_info and not wall_collision_sfx.playing:
		wall_collision_sfx.pitch_scale = randf_range(0.8, 1.2)
		wall_collision_sfx.play()

func _load_stats() -> void:
	var rnd = randf()

	for info in ENEMY_STATS:
		var prob = info[0]
		var stats = info[1]
		if rnd <= prob:
			enemy_stats = stats
			break
		rnd -= prob
	
	if not enemy_stats:
		enemy_stats = ENEMY_STATS[0][1]
	
	movement_cmp.start_speed = enemy_stats.start_speed
	movement_cmp.speed = enemy_stats.speed
	movement_cmp.acceleration = enemy_stats.acceleration
	movement_cmp.gravity_enable = enemy_stats.gravity_enable
	movement_cmp.gravity_acceleration = enemy_stats.gravity_acceleration
	if enemy_stats.gravity_dir_random:
		movement_cmp.gravity_dir = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT].pick_random()
	else:
		movement_cmp.gravity_dir = enemy_stats.gravity_dir

	hitbox_cmp.enemy_stats = enemy_stats
	
	color_rect.color = enemy_stats.color
	color_rect.size = enemy_stats.size
	color_rect.position = -enemy_stats.size / 2
	
	var rect := RectangleShape2D.new()
	rect.size = enemy_stats.size
	collision_shape.shape = rect
	hitbox_collision_shape.shape = rect
	boundary_detection_collision_shape.shape = rect
