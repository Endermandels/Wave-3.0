extends Control
class_name FocusComponent

@export_group("External Nodes")
@export var default_focus: Control

var ui_keyboard_navigation: bool = false

func focus_new_default(new_default: Control) -> void:
	default_focus = new_default
	if ui_keyboard_navigation:
		default_focus.grab_focus()

func update() -> void:
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