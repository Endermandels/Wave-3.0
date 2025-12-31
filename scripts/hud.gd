extends Control
class_name HUD

@export_group("Internal Nodes")
@export var wave_label: Label
@export var health_bar_cmp: HealthBarComponent

func update() -> void:
	wave_label.text = "Wave: " + str(GameManager.game_state.wave)
	health_bar_cmp.set_progress((float(GameManager.player_stats.hp) / GameManager.player_stats.max_hp) * 100)
