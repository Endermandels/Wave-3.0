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

func handle_hurtbox(hurtbox: HurtboxComponent) -> void:
    var hitbox: HitboxComponent = hurtbox.get_current_hitbox()
    if not hitbox: return

    hp -= hitbox.dmg

func is_dead() -> bool:
    return not alive
