extends CharacterBody2D
class_name Player

@export_group("Internal Nodes")
@export var input_cmp: InputComponent
@export var movement_cmp: MovementComponent

func update() -> void:
    pass

func physics_update() -> void:
    input_cmp.update()
    movement_cmp.handle_movement(self, input_cmp.input_vector)

    move_and_slide()