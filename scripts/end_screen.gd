extends Node2D
class_name EndScreen

var MAIN_MENU_SCENE: PackedScene

@export_group("Internal Nodes")
@export var wave_label: Label
@export var time_label: Label
@export var scene_transition_cmp: SceneTransitionComponent
@export var main_menu_scene_transition_cmp: SceneTransitionComponent
@export var return_btn: Button
@export_group("Resources")
@export_file_path("*.tscn") var main_menu: String

func _ready() -> void:
	MAIN_MENU_SCENE = load(main_menu)
	wave_label.text = "Waves Survived: %d" % (GameManager.game_state.wave - 1)
	time_label.text = "Time: %.3f s" % GameManager.game_state.elapsed_time
	scene_transition_cmp.transition_in()

func _process(delta: float) -> void:
	scene_transition_cmp.update(delta)
	main_menu_scene_transition_cmp.update(delta)
	if return_btn.button_pressed:
		_on_return_button_pressed()
	
func _on_return_button_pressed():
	main_menu_scene_transition_cmp.transition_out(MAIN_MENU_SCENE)
