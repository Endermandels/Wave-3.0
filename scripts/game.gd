extends Node2D
class_name Game

@export_group("Internal Nodes")
@export var player: Player

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("quit"):
		get_tree().quit()

func _process(_delta: float) -> void:
	player.update()

func _physics_process(_delta: float) -> void:
	player.physics_update()
