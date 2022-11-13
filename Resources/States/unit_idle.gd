extends BaseState

export (NodePath) var state_label_node
export (NodePath) var moving_node
export var distanceCheck := 10

onready var state_label: Label = get_node(state_label_node)
onready var moving_state: BaseState = get_node(moving_node)




func enter() -> void:
	.enter()
	parent_unit.velocity = Vector2.ZERO
	state_label.text = "Idle"


#func input(event: InputEvent) -> BaseState:
#		if event.is_action_pressed("click"): #left mouse click
#		target = get_global_mouse_position()



func physics_process(delta: float) -> BaseState:
	if parent_unit.position.distance_to(parent_unit.target) > distanceCheck:
		return moving_state
	return null




#	if event.is_action_pressed("click"): #left mouse click
#		target = get_global_mouse_position()
