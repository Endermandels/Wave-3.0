extends Resource
class_name Stats

var stats_changed: bool = false

@export_group("Rendering")
@export var size: Vector2 = Vector2(8, 8) ## Size in pixels
@export var color: Color = Color.WHITE

@export_group("Movement")
@export_range(0, 1) var acceleration: float = 0.2:
	set(val):
		stats_changed = true
		acceleration = val

@export_range(0, 1000, 1, "or_greater") var speed: float = 300:
	set(val):
		stats_changed = true
		speed = val
		
@export_range(0, 1000, 1, "or_greater") var start_speed: float = 0

func is_changed() -> bool:
	var res = stats_changed
	stats_changed = false
	return res