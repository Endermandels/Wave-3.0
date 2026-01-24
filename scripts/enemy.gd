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
@export var movement_cmp: MovementComponent
@export var enable_collision_timer: Timer
@export var collision_shape: CollisionShape2D
@export var wall_collision_sfx: AudioStreamPlayer2D
@export var hitbox_cmp: HitboxComponent
@export var hitbox_collision_shape: CollisionShape2D
@export var color_rect: ColorRect

@export_group("Resources")
@export var enemy_stats: EnemyStats

func _ready() -> void:
	_load_stats()
	collision_shape.disabled = true
	movement_cmp.init_velocity(self, self.global_position.direction_to(GameManager.game_state.player_pos))

func update() -> void:
	if collision_shape.disabled and enable_collision_timer.is_stopped():
		collision_shape.disabled = false

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

	if enemy_stats.border_delay > 0:
		enable_collision_timer.start(enemy_stats.border_delay)
