extends Control
class_name HUD

@export_group("Internal Nodes")
@export var wave_label: Label
@export var time_label: Label

func _ready() -> void:
	wave_label.text = "Wave: %d" % GameManager.game_state.wave
	time_label.text = "%.3f" % GameManager.game_state.elapsed_time

func update() -> void:
	wave_label.text = "Wave: %d" % GameManager.game_state.wave
	time_label.text = "%.3f" % GameManager.game_state.elapsed_time
