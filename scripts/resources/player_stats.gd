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

func take_dmg(amount: int) -> void:
	hp -= amount

func is_dead() -> bool:
	return not alive
