extends Node

var game_state: GameState = GameState.new()
var player_stats: PlayerStats = PlayerStats.new()

var elapsed_time: float = 0.0

func update(delta: float) -> void:
    if elapsed_time >= game_state.wave_length:
        game_state.next_wave()
        elapsed_time = 0
    elapsed_time += delta

