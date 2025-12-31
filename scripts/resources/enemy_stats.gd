extends Resource
class_name EnemyStats

@export_group("Settings")
@export var damage: int = 5

@export_group("Movement")
@export var acceleration: float = 0.2
@export var speed: float = 300
@export var start_speed: float = 300