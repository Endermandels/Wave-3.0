extends Area2D
class_name HurtboxComponent

@export_group("Settings")
@export var invincible_on_hit: bool = true ## Whether the hurtbox is disabled after a collision

@export_group("Internal Nodes")
@export var invincibility_timer: Timer

var current_hitbox: HitboxComponent = null

func physics_update() -> void:
	if not monitoring and invincibility_timer.is_stopped():
		monitoring = true

	if not monitoring: return

	for hitbox: HitboxComponent in get_overlapping_areas():
		if not current_hitbox or hitbox.priority > current_hitbox.priority:
			current_hitbox = hitbox
			
	if current_hitbox and invincible_on_hit:
		monitoring = false
		invincibility_timer.start()

func get_current_hitbox() -> HitboxComponent:
	var res = current_hitbox
	current_hitbox = null
	return res