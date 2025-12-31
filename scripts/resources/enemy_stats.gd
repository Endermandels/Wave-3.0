extends Stats
class_name EnemyStats

@export_group("Settings")
@export var dmg: int = 1:
    set(val):
        stats_changed = true
        dmg = val