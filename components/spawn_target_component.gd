extends Node2D
class_name SpawnTargetComponent

# Add more in a subclass which extends SpawnTargetComponent

func update(_delta: float) -> void:
    pass

func physics_update(_delta: float) -> void:
    pass

func spawn(spawned) -> void:
    add_child(spawned)