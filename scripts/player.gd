extends CharacterBody2D
class_name Player

@export_group("Internal Nodes")
@export var input_cmp: InputComponent
@export var movement_cmp: MovementComponent
@export var anim_cmp: AnimationComponent
@export var hurtbox_cmp: HurtboxComponent
@export var color_rect: ColorRect

@onready var stats: PlayerStats = GameManager.player_stats

func update() -> void:
	if stats.is_changed():
		_apply_stats()
	
	if stats.is_dead():
		color_rect.hide()
		return
	
	anim_cmp.flash(not hurtbox_cmp.monitoring)

func physics_update(delta: float) -> void:
	input_cmp.update()
	movement_cmp.handle_movement(self, input_cmp.input_vector, delta)
	hurtbox_cmp.physics_update()
	stats.handle_hurtbox(hurtbox_cmp)
	GameManager.game_state.player_pos = global_position

func _apply_stats() -> void:
	movement_cmp.speed = stats.speed
	movement_cmp.acceleration = stats.acceleration
