extends SpawnTargetComponent
class_name EnemySpawnTarget

func update(_delta: float) -> void:
	for enemy: Enemy in get_children():
		enemy.update()

func physics_update(delta: float) -> void:
	for enemy: Enemy in get_children():
		enemy.physics_update(delta)

func spawn(spawned: Enemy) -> void:
	add_child(spawned)
