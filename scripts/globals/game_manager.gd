extends Node

var game_state: GameState = GameState.new()
var player_stats: PlayerStats = PlayerStats.new()

func update(delta: float) -> void:
    game_state.update(delta)
