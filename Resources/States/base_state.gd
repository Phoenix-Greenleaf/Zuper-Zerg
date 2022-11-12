extends Node2D
class_name BaseState

var parent_unit: BaseUnits
#var target

func enter() -> void:
	pass

func exit() -> void:
	pass

func input(event: InputEvent) -> BaseState: #event only happens once if held. for held commands, use Input singleton for polling.
	if event.is_action_pressed("click"): #left mouse click
		parent_unit.target = get_global_mouse_position()
	return null

func process(delta: float) -> BaseState:
	return null

func physics_process(delta: float) -> BaseState:
	return null
