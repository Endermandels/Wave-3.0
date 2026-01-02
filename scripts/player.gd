extends CharacterBody2D
class_name Player

@export_group("Internal Nodes")
@export var input_cmp: InputComponent
@export var movement_cmp: MovementComponent
@export var anim_cmp: AnimationComponent
@export var hurtbox_cmp: HurtboxComponent
@export var color_rect: ColorRect
@export var health_bar_cmp: HealthBarComponent
@export var hurt_sfx: AudioStreamPlayer2D
@export var death_sfx: AudioStreamPlayer2D

@onready var stats: PlayerStats = GameManager.player_stats

var played_death_sfx: bool = false

func update() -> void:
	if stats.is_changed():
		_apply_stats()
	
	if stats.is_dead():
		color_rect.hide()
		health_bar_cmp.hide()
		if not played_death_sfx:
			played_death_sfx = true
			death_sfx.play()
		return
	
	anim_cmp.flash(not hurtbox_cmp.monitoring)
	health_bar_cmp.set_progress((float(stats.hp) / stats.max_hp) * 100)

func physics_update(delta: float) -> void:
	input_cmp.update()
	movement_cmp.handle_movement(self, input_cmp.input_vector, delta)
	hurtbox_cmp.physics_update()
	if stats.alive:
		var hitbox: HitboxComponent = hurtbox_cmp.get_current_hitbox()
		if hitbox:
			stats.take_dmg(hitbox.dmg)
			hurt_sfx.pitch_scale = randf_range(0.8, 1.2)
			hurt_sfx.play()
	GameManager.game_state.player_pos = global_position

func _apply_stats() -> void:
	movement_cmp.speed = stats.speed
	movement_cmp.acceleration = stats.acceleration
