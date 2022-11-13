extends Node
class_name StateManager

export (NodePath) var starting_state

var current_state: BaseState


func change_state(new_state: BaseState) -> void:
	if current_state:
		current_state.exit()

	current_state = new_state
#	state_label.text = current_state
	current_state.enter()



func init(parent_unit: BaseUnits) -> void:
	for child in get_children():
		child.parent_unit = parent_unit
#		child.state_label = state_Label
		
	change_state(get_node(starting_state))



func physics_process(delta: float) -> void:
	var new_state = current_state.physics_process(delta)
	if new_state:
		change_state(new_state)



func input(event: InputEvent) -> void:
	var new_state = current_state.input(event)
	if new_state:
		change_state(new_state)



func process(delta: float) -> void:
	var new_state = current_state.process(delta)
	if new_state:
		change_state(new_state)
