extends Control
class_name MainMenu

var GAME_SCENE: PackedScene

@export_group("Internal Nodes")
@export var scene_transition_cmp: SceneTransitionComponent
@export var game_scene_transition_cmp: SceneTransitionComponent
@export var main_section: Control
@export var credits_section: Control
@export_subgroup("Main Menu Nodes")
@export var author_label: Label
@export var version_label: Label
@export var play_btn: Button
@export var settings_btn: Button
@export var credits_btn: Button
@export var quit_btn: Button
@export_subgroup("Credits Nodes")
@export var credits_scroll_container: ScrollContainer
@export var credits_return_btn: Button
@export_group("Resources")
@export_file_path("*.tscn") var game_scene: String

var ui_keyboard_navigation: bool = false
var default_focus: Control = null

func _ready() -> void:
	GAME_SCENE = load(game_scene)
	scene_transition_cmp.transition_in()
	author_label.text = GameManager.meta_data.author
	version_label.text= GameManager.meta_data.version
	main_section.show()
	credits_section.hide()
	default_focus = play_btn

func _process(delta: float) -> void:
	# Mouse Focus
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		ui_keyboard_navigation = false

		# Only release focus if not clicking on any button node
		var hovered = get_viewport().gui_get_hovered_control()
		if not (hovered is Button):
			get_viewport().gui_release_focus()
	
	# Keyboard Focus
	if (Input.is_action_pressed("ui_up") or 
			Input.is_action_pressed("ui_down") or 
			Input.is_action_pressed("ui_left") or 
			Input.is_action_pressed("ui_right")):
		# Select Play Button if no button is focused
		ui_keyboard_navigation = true
		var focused = get_viewport().gui_get_focus_owner()
		if not focused and default_focus:
			default_focus.grab_focus()

	if main_section.visible:
		# Main Section

		# Update Scene Transitions
		scene_transition_cmp.update(delta)
		game_scene_transition_cmp.update(delta)
		
		# Stop while transitioning
		if scene_transition_cmp.transitioning or game_scene_transition_cmp.transitioning: return
		
		# Button presses
		if play_btn.button_pressed:
			_on_play_button_pressed()
		if credits_btn.button_pressed:
			_on_credits_button_pressed()
		if quit_btn.button_pressed or Input.is_action_just_pressed("ui_cancel"):
			get_tree().quit()
	elif credits_section.visible:
		# Credits Section

		# Scroll Bar Keyboard Input
		if Input.is_action_pressed("ui_up"):
			credits_scroll_container.get_v_scroll_bar().value -= 10
		elif Input.is_action_pressed("ui_down"):
			credits_scroll_container.get_v_scroll_bar().value += 10

		# Return to Main Menu
		if credits_return_btn.button_pressed or Input.is_action_just_pressed("ui_cancel"):
			_on_credits_return_button_pressed()

func _on_play_button_pressed() -> void:
	game_scene_transition_cmp.transition_out(GAME_SCENE)

func _on_credits_button_pressed() -> void:
	main_section.hide()
	credits_section.show()
	var credits_scroll_bar = credits_scroll_container.get_v_scroll_bar()
	credits_scroll_bar.value = 0 # Reset scroll height
	default_focus = credits_return_btn
	if ui_keyboard_navigation:
		credits_return_btn.grab_focus()

func _on_credits_return_button_pressed() -> void:
	main_section.show()
	credits_section.hide()
	default_focus = play_btn
	if ui_keyboard_navigation:
		play_btn.grab_focus()
