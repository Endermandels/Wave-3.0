extends Node2D
class_name LoseScreen

@export_group("Internal Nodes")
@export var wave_label: Label
@export var time_label: Label
@export var scene_transition_cmp: SceneTransitionComponent

func _ready() -> void:
    wave_label.text = "Wave: %d" % GameManager.game_state.wave
    time_label.text = "Time: %.3f" % GameManager.game_state.elapsed_time
    scene_transition_cmp.transition_in()

func _process(_delta: float) -> void:
    scene_transition_cmp.update()
