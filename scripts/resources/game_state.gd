extends Resource
class_name GameState

@export_group("Settings")
@export var wave_length: float = 10.0 ## Wave length in seconds
@export var wave: int = 1 ## Current Wave number
@export var waves_to_win: int = 5 ## The number of Waves beaten to win
@export var shop_length: float = 5.0 ## Shop length in seconds

var elapsed_time: float = 0.0 ## in seconds
var player_pos: Vector2 = Vector2.ZERO
var player_won: bool = false
var new_wave: bool = true
var shop_open: bool = false

func update(delta: float) -> void:
    if player_won: return
    if !shop_open and elapsed_time >= (wave_length + shop_length) * wave - shop_length: # Don't count the first non-existent shop length
        if wave == waves_to_win:
            player_won = true
        else:
            shop_open = true
    elif shop_open and elapsed_time >= (wave_length + shop_length) * wave:
        shop_open = false
        next_wave()
    elapsed_time = clampf(elapsed_time + delta, 0, (wave_length + shop_length) * waves_to_win - shop_length)

func next_wave() -> void:
    wave += 1
    new_wave = true

func is_new_wave() -> bool:
    var res = new_wave
    new_wave = false
    return res

func reset() -> void:
    wave = 1
    elapsed_time = 0.0
    player_won = false