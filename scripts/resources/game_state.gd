extends Resource
class_name GameState

@export_group("Settings")
@export var wave_length: float = 10.0 ## Wave length in seconds
@export var wave: int = 1 ## Current Wave number
@export var waves_to_win: int = 5 ## The number of Waves beaten to win

var elapsed_time: float = 0.0 ## in seconds
var player_pos: Vector2 = Vector2.ZERO
var player_won: bool = false
var new_wave: bool = true

func update(delta: float) -> void:
    if player_won: return
    if elapsed_time >= wave_length * wave:
        next_wave()
    elapsed_time = clampf(elapsed_time + delta, 0, waves_to_win * wave_length)

func next_wave() -> void:
    wave += 1
    new_wave = true
    if wave > waves_to_win:
        player_won = true

func is_new_wave() -> bool:
    var res = new_wave
    new_wave = false
    return res