extends BaseState

export (NodePath) var moving_node

onready var moving_state: BaseState = get_node(moving_node)



func enter() -> void:
	.enter()
	parent_unit.velocity = Vector2.ZERO

func physics_process(delta: float) -> BaseState:
#	if position.distance_to(target) > 5:
	if parent_unit.position.distance_to(target) > 5:
		return moving_state
	return null
