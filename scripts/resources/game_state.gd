extends Resource
class_name GameState

@export_group("Settings")
@export var wave_length: float = 10.0 ## Wave length in seconds
@export var wave: int = 1 ## Current Wave number

var player_pos: Vector2 = Vector2.ZERO
var new_wave: bool = true
var elapsed_time: float = 0.0 ## in seconds

func update(delta: float) -> void:
    if elapsed_time >= wave_length * wave:
        next_wave()
    elapsed_time += delta

func next_wave() -> void:
    wave += 1
    new_wave = true

func is_new_wave() -> bool:
    var res = new_wave
    new_wave = false
    return res