extends Node2D
class_name Game

@export_group("Internal Nodes")
@export var player: Player
@export var hud: HUD
@export var spawner_cmp: SpawnerComponent
@export var spawn_target_cmp: SpawnTargetComponent
@export var lose_scene_transition_cmp: SceneTransitionComponent
@export var win_scene_transition_cmp: SceneTransitionComponent
@export var scene_transition_cmp: SceneTransitionComponent

@export_group("Resources")
@export var lose_scene: PackedScene
@export var win_scene: PackedScene

func _ready() -> void:
	scene_transition_cmp.transition_in()

func _process(delta: float) -> void:
	scene_transition_cmp.update(delta)
	if scene_transition_cmp.transitioning: return
	player.update()
	hud.update()
	if not GameManager.game_state.player_won:
		spawner_cmp.update(delta)
		spawn_target_cmp.update(delta)
	GameManager.update(delta)
	if GameManager.game_state.is_new_wave():
		spawn_target_cmp.delete_children()
	if GameManager.player_stats.is_dead():
		lose_scene_transition_cmp.transition_out(lose_scene)
		lose_scene_transition_cmp.update(delta)
	elif GameManager.game_state.player_won:
		win_scene_transition_cmp.transition_out(win_scene)
		win_scene_transition_cmp.update(delta)

func _physics_process(delta: float) -> void:
	if scene_transition_cmp.transitioning: return
	player.physics_update(delta)
	spawn_target_cmp.physics_update(delta)
