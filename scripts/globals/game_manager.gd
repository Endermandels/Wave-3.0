extends Node

const META_DATA = preload("res://resources/meta_data.tres")
const GAME_STATE = preload("res://resources/game_state.tres")
const PLAYER_STATS = preload("res://resources/stats/player_stats.tres")

var meta_data: MetaData = META_DATA.duplicate()
var game_state: GameState = GAME_STATE.duplicate()
var player_stats: PlayerStats = PLAYER_STATS.duplicate()

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("quit"):
		get_tree().quit()

func update(delta: float) -> void:
	if player_stats.is_dead(): return
	game_state.update(delta)
