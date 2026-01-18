extends Stats
class_name PlayerStats

@export_group("Settings")
@export var max_hp: int = 20:
	set(val):
		stats_changed = true
		max_hp = val

var alive: bool = true:
	set(val):
		stats_changed = true
		alive = val

var hp: int = max_hp:
	set(val):
		stats_changed = true
		hp = clampi(val, 0, max_hp)
		if hp == 0:
			alive = false

var poison_dmg_per_second: int = 0:
	set(val):
		stats_changed = true
		poison_dmg_per_second = val

var poison_duration: float = 0.0
var last_poison_dmg: int = 1000

func update(delta: float) -> void:
	if poison_duration > 0:
		poison_duration -= delta
		if last_poison_dmg > int(poison_duration):
			hp -= poison_dmg_per_second
			last_poison_dmg = int(poison_duration)
	else:
		poison_dmg_per_second = 0

func is_dead() -> bool:
	return not alive

func reset() -> void:
	hp = max_hp
	alive = true

func hit_by(enemy_stats: EnemyStats) -> void:
	hp -= enemy_stats.dmg
	if enemy_stats.poison_duration > 0 and enemy_stats.poison_dmg_per_second > 0:
		poison_duration = enemy_stats.poison_duration
		poison_dmg_per_second = enemy_stats.poison_dmg_per_second
		last_poison_dmg = 1000
