extends Node2D
class_name SpawnTargetComponent

# Add more in a subclass which extends SpawnTargetComponent

func update(_delta: float) -> void:
    pass

func physics_update(_delta: float) -> void:
    pass

func delete_children() -> void:
    for child in get_children():
        child.queue_free()

func spawn(spawned) -> void:
    add_child(spawned)