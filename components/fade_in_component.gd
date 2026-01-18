extends Node
class_name FadeInComponent

## Fade alpha of selected node in at specified rate

@export_group("Settings")
@export var delay: float = 1.0 ## Delay in seconds before fade in
@export var duration: float = 1.0 ## Duration of fade in

@export_group("External Nodes")
@export var target: Node ## Node to fade in

var elapsed_time: float = 0.0
var finished: bool = false

func _ready() -> void:
    target.modulate.a = 0

func update(delta: float) -> void:
    if finished: return
    elapsed_time += delta
    
    if elapsed_time < delay: return
    target.modulate.a = clampf(elapsed_time - delay, 0, 1)

    if target.modulate.a == 1:
        finished = true
