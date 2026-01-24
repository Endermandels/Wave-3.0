extends Stats
class_name EnemyStats

@export_group("Settings")
@export var dmg: int = 1:
	set(val):
		stats_changed = true
		dmg = val

@export var follows_player: bool = false:
	set(val):
		stats_changed = true
		follows_player = val

@export_subgroup("Gravity")
@export var gravity_enable: bool = false:
	set(val):
		stats_changed = true
		gravity_enable = val
@export var gravity_dir_random: bool = false
@export var gravity_dir: Vector2 = Vector2.DOWN
@export var gravity_acceleration: float = 8.0

@export_subgroup("Poison")
@export var poison_dmg_per_second: int = 0:
	set(val):
		stats_changed = true
		poison_dmg_per_second = val
@export var poison_duration: float = 0.0