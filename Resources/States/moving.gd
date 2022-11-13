extends BaseState

export (NodePath) var state_label_node
export (NodePath) var unit_idle_node
export (int) var moveDistanceCheck = 5

onready var state_label: Label = get_node(state_label_node)
onready var unit_idle_state: BaseState =  get_node(unit_idle_node)


func enter() -> void:
	.enter()
	state_label.text = "Moving"
	



func physics_process(delta: float) -> BaseState:
	parent_unit.velocity = parent_unit.position.direction_to(parent_unit.target) * parent_unit.speed
	parent_unit.move_and_slide(parent_unit.velocity)
	
	if parent_unit.position.distance_to(parent_unit.target) < moveDistanceCheck:
		return unit_idle_state
	
	return null
