extends BaseState

export (NodePath) var state_label_node
export (NodePath) var moving_node
export (int) var idle_time_min = 1
export (int) var idle_time_max = 3

onready var state_label: Label = get_node(state_label_node)
onready var moving_state: BaseState = get_node(moving_node)
onready var timer = $IdleTimer

var random = RandomNumberGenerator.new()




func enter() -> void:
	.enter()
	parent_unit.velocity = Vector2.ZERO
	state_label.text = name
	random.randomize()
	timer.time_left = random.randi_range(idle_time_min, idle_time_max)
	print(parent_unit.name + " " + name + timer.time_left)
	timer.start()



#func input(event: InputEvent) -> BaseState:
#	if event.is_action_pressed("left_click"):
#		parent_unit.target = get_global_mouse_position()
##	if parent_unit.position.distance_to(parent_unit.target) > distanceCheck:
##		return moving_state
#	return null


func _on_IdleTimer_timeout() -> BaseState: 
	return moving_state
