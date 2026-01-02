extends Control
class_name MainMenu

@export_group("Internal Nodes")
@export var play_btn: Button
@export var settings_btn: Button
@export var credits_btn: Button
@export var quit_btn: Button
@export var scene_transition_cmp: SceneTransitionComponent
@export var game_scene_transition_cmp: SceneTransitionComponent
@export var author_label: Label
@export var version_label: Label

@export_group("Resources")
@export var game_scene: PackedScene

func _unhandled_key_input(event: InputEvent) -> void:
	if (event.is_action_pressed("ui_up") or 
			event.is_action_pressed("ui_down") or 
			event.is_action_pressed("ui_left") or 
			event.is_action_pressed("ui_right")):
		# Select Play Button if no button is focused
		var focused = get_viewport().gui_get_focus_owner()
		if not focused:
			play_btn.grab_focus()

func _ready() -> void:
	scene_transition_cmp.transition_in()
	author_label.text = GameManager.meta_data.author
	version_label.text= GameManager.meta_data.version

func _process(delta: float) -> void:
	scene_transition_cmp.update(delta)
	game_scene_transition_cmp.update(delta)
	
	if scene_transition_cmp.transitioning or game_scene_transition_cmp.transitioning: return
	if play_btn.button_pressed:
		_on_play_button_pressed()
	if quit_btn.button_pressed:
		get_tree().quit()

func _on_play_button_pressed() -> void:
	game_scene_transition_cmp.transition_out(game_scene)