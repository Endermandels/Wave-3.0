extends Control
class_name MainMenu

@export_group("Internal Nodes")
@export var play_btn: Button
@export var settings_btn: Button
@export var credits_btn: Button
@export var quit_btn: Button

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
	pass
