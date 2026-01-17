extends Node2D
class_name SpawnerComponent

@export_group("Settings")
@export_range(0, 10) var spawn_rate: float = 1.0 ## Spawns per second

@export_group("External Nodes")
@export var spawn_target: SpawnTargetComponent

@export_group("Resources")
@export var spawnable_scenes: Array[PackedScene]
@export var spawnable_scene_probabilities: Array[float]

var elapsed_time: float = 0.0

func update(delta: float) -> void:
	if elapsed_time > 1 / spawn_rate:
		_spawn()
		elapsed_time = 0.0
	elapsed_time += delta

func _spawn() -> void:
	var spawn_points: Array = get_children()
	if spawn_points.size() == 0:
		push_warning("[%s] No spawn point children" % self.name)
		return

	var spawn_point = spawn_points.pick_random()

	var rnd = randf()
	var spawned
	
	if not spawnable_scene_probabilities or spawnable_scene_probabilities.size() < 1:
		spawned = spawnable_scenes.pick_random().instantiate()
	else:
		var i = 0
		for prob in spawnable_scene_probabilities:
			if rnd <= prob:
				spawned = spawnable_scenes[i].instantiate()
				break
			i += 1
			rnd -= prob 
		if not spawned:
			spawned = spawnable_scenes[0].instantiate()
	spawned.global_position = spawn_point.global_position
	spawn_target.spawn(spawned)
		