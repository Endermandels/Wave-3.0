extends Stats
class_name EnemyStats

@export_group("Settings")
@export var dmg: int = 1:
    set(val):
        stats_changed = true
        dmg = val

@export var border_delay: float = 0.5 ## The amount of time in seconds before border collisions are activated (0 for no border collisions)