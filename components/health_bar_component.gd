extends TextureProgressBar
class_name HealthBarComponent

@export_group("Internal Nodes")
@export var under_color_rect: ColorRect
@export var porgress_color_rect: ColorRect

func _ready() -> void:
    set_progress(100)

## amount as a percentage
func set_progress(amount: float) -> void:
    value = amount
    porgress_color_rect.size.x = under_color_rect.size.x * value / 100
