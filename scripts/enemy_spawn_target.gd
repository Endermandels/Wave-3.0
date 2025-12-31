extends SpawnTargetComponent
class_name EnemySpawnTarget

const ENEMY_STATS: Array[EnemyStats] = [
	preload("res://resources/stats/basic_enemy_stats.tres")
]

func update(_delta: float) -> void:
	for enemy: Enemy in get_children():
		enemy.update()

func physics_update(delta: float) -> void:
	for enemy: Enemy in get_children():
		enemy.physics_update(delta)

func spawn(spawned: Enemy) -> void:
	spawned.enemy_stats = ENEMY_STATS.pick_random().duplicate()
	add_child(spawned)
