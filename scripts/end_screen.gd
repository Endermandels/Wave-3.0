extends Node2D
class_name EndScreen

@export_group("Internal Nodes")
@export var wave_label: Label
@export var time_label: Label
@export var scene_transition_cmp: SceneTransitionComponent

func _ready() -> void:
    wave_label.text = "Waves Survived: %d" % (GameManager.game_state.wave - 1)
    time_label.text = "Time: %.3f s" % GameManager.game_state.elapsed_time
    scene_transition_cmp.transition_in()

func _process(_delta: float) -> void:
    scene_transition_cmp.update()
