extends Node2D
class_name Game

@export_group("Internal Nodes")
@export var player: Player
@export var hud: HUD
@export var spawner_cmp: SpawnerComponent
@export var spawn_target_cmp: SpawnTargetComponent
@export var scene_transition_cmp: SceneTransitionComponent

@export_group("Resources")
@export var lose_scene: PackedScene

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("quit"):
		get_tree().quit()

func _process(delta: float) -> void:
	player.update()
	hud.update()
	spawner_cmp.update(delta)
	spawn_target_cmp.update(delta)
	GameManager.update(delta)
	if GameManager.game_state.is_new_wave():
		spawn_target_cmp.delete_children()
	if GameManager.player_stats.is_dead():
		scene_transition_cmp.transition_out(lose_scene)
		scene_transition_cmp.update()

func _physics_process(delta: float) -> void:
	player.physics_update(delta)
	spawn_target_cmp.physics_update(delta)
