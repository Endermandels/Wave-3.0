extends Resource
class_name GameState

var player_pos: Vector2 = Vector2.ZERO
var wave: int = 1

func next_wave() -> void:
    wave += 1