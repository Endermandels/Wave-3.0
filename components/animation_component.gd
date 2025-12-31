extends Node
class_name AnimationComponent

@export_group("External Nodes")
@export var anim_player: AnimationPlayer

func flash(enabled: bool, priority: bool = false) -> void:
	if not priority and anim_player.current_animation != "" and anim_player.current_animation != "flash": return
	if enabled and not anim_player.is_playing(): 
		anim_player.play("flash")
	elif not enabled and anim_player.is_playing():
		anim_player.play("RESET")
