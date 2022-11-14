extends Node2D
class_name BaseState

onready var parent_unit: BaseUnits


func enter() -> void:
	pass

func exit() -> void:
	pass

func input(event: InputEvent) -> BaseState:
	if event.is_action_pressed("left_click"):
		parent_unit.target = get_global_mouse_position()
	return null

func process(_delta: float) -> BaseState:
	return null

func physics_process(_delta: float) -> BaseState:
	return null
