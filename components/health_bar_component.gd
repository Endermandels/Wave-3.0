extends TextureProgressBar
class_name HealthBarComponent

@export_group("Internal Nodes")
@export var under_color_rect: ColorRect
@export var progress_color_rect: ColorRect

@onready var progress_color_save: Color = progress_color_rect.color

func _ready() -> void:
	set_progress(100)

## amount as a percentage
func set_progress(amount: float) -> void:
	value = amount
	progress_color_rect.size.x = under_color_rect.size.x * value / 100

func set_color(col: Color) -> void:
	progress_color_rect.color = col

func restore_color() -> void:
	progress_color_rect.color = progress_color_save
