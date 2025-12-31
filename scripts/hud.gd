extends Control
class_name HUD

@export_group("Internal Nodes")
@export var wave_label: Label

func update() -> void:
    wave_label.text = "Wave: " + str(GameManager.game_state.wave)