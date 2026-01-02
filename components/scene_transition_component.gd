extends ColorRect
class_name SceneTransitionComponent

enum TransitionType {
	CIRCLE_OUT,
	CIRCLE_IN,
	INVERSE_CIRCLE_OUT
}

@export_group("Settings")
@export var duration: float = 1.5 ## Seconds to completion
@export var delay: float = 0.0 ## Seconds to start
@export var transition_volume: float = -20.0 ## Volume at start/end of transition (depends on transitioning in/out respectively)
@export var type: TransitionType = TransitionType.CIRCLE_OUT

@export_group("Internal Nodes")
@export var delay_timer: Timer

var target_scene: PackedScene = null
var transitioning: bool = false
var progress: float = 0.0 ## in percentage

func _notification(what: int) -> void:
	if what == NOTIFICATION_RESIZED:
		material.set_shader_parameter("screen_size", get_viewport_rect().size)

func _ready() -> void:
	hide()
	# Make sure shader material is instantiated for this instance
	material = material.duplicate()
	material.set_shader_parameter("screen_size", get_viewport_rect().size)
	material.set_shader_parameter("transition_type", type)
	size = get_viewport_rect().size

func update(delta: float) -> void:
	if not transitioning: return
	
	if delay_timer.is_stopped():
		progress += delta / duration

	var master_bus_index = AudioServer.get_bus_index("Master")
	var volume_progress = progress
	if not _is_transition_out():
		volume_progress = 1 - progress
	AudioServer.set_bus_volume_db(master_bus_index, clampf(volume_progress * transition_volume, -100, 0))

	material.set_shader_parameter("progress", progress)
	if progress >= 1:
		transitioning = false
		hide()
		if _is_transition_out():
			get_tree().change_scene_to_packed(target_scene)

func _is_transition_out() -> bool:
	return type == TransitionType.CIRCLE_OUT

func transition_out(scene: PackedScene) -> void:
	if transitioning: return
	show()
	transitioning = true
	target_scene = scene
	delay_timer.start(delay)

func transition_in() -> void:
	if transitioning: return
	show()
	transitioning = true
	delay_timer.start(delay)
