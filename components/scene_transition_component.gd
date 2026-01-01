extends Control
class_name SceneTransitionComponent

enum TransitionType {
	CIRCLE_OUT,
	CIRCLE_IN
}

@export_group("Settings")
@export var speed: float = 10.0
@export var delay: float = 0.0
@export var type: TransitionType = TransitionType.CIRCLE_OUT
@export var color: Color = Color.BLACK

@export_group("Internal Nodes")
@export var delay_timer: Timer

var target_scene: PackedScene = null
var transitioning: bool = false
var progress: float = 0.0

func _draw() -> void:
	if not transitioning: return
	
	if delay_timer.is_stopped():
		progress += speed
	
	if type == TransitionType.CIRCLE_OUT:
		draw_circle(get_viewport_rect().size / 2, progress, color)
		if progress > get_viewport_rect().size.x:
			get_tree().change_scene_to_packed(target_scene)
	elif type == TransitionType.CIRCLE_IN:
		draw_circle(get_viewport_rect().size / 2, clampf(get_viewport_rect().size.x - progress, 0, INF), color)
		if progress >= get_viewport_rect().size.x:
			transitioning = false

func update() -> void:
	if not transitioning: return
	queue_redraw()

func transition_out(scene: PackedScene) -> void:
	if transitioning: return
	transitioning = true
	target_scene = scene
	delay_timer.start(delay)

func transition_in() -> void:
	if transitioning: return
	transitioning = true
	delay_timer.start(delay)
