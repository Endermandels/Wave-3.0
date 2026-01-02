extends Control
class_name SceneTransitionComponent

enum TransitionType {
	CIRCLE_OUT,
	CIRCLE_IN
}

@export_group("Settings")
@export var duration: float = 1.5 ## Seconds to completion
@export var delay: float = 0.0 ## Seconds to start
@export var end_transition_volume: float = -20.0 ## Target volume at end of transition
@export var type: TransitionType = TransitionType.CIRCLE_OUT
@export var color: Color = Color.BLACK

@export_group("Internal Nodes")
@export var delay_timer: Timer

var target_scene: PackedScene = null
var transitioning: bool = false
var progress: float = 0.0 ## in percentage

func _draw() -> void:
	if not transitioning: return
	
	if type == TransitionType.CIRCLE_OUT:
		draw_circle(get_viewport_rect().size / 2, progress * get_viewport_rect().size.x, color)
		if progress >= 1:
			get_tree().change_scene_to_packed(target_scene)
	elif type == TransitionType.CIRCLE_IN:
		draw_circle(get_viewport_rect().size / 2, clampf(get_viewport_rect().size.x - progress * get_viewport_rect().size.x, 0, INF), color)
		if progress >= 1:
			transitioning = false

func update(delta: float) -> void:
	if not transitioning: return
	
	if delay_timer.is_stopped():
		progress += delta / duration
	
	queue_redraw()

	var master_bus_index = AudioServer.get_bus_index("Master")
	var volume_progress = progress
	if not _is_transition_out():
		volume_progress = 1 - progress
	AudioServer.set_bus_volume_db(master_bus_index, volume_progress * end_transition_volume)

func _is_transition_out() -> bool:
	return type == TransitionType.CIRCLE_OUT

func transition_out(scene: PackedScene) -> void:
	if transitioning: return
	transitioning = true
	target_scene = scene
	delay_timer.start(delay)

func transition_in() -> void:
	if transitioning: return
	transitioning = true
	delay_timer.start(delay)
