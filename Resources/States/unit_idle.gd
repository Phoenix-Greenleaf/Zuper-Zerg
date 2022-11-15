extends BaseState

export (NodePath) var state_label_node
export (NodePath) var moving_node
export (float) var idle_time_min = 1.0
export (float) var idle_time_max = 2.0

onready var state_label: Label = get_node(state_label_node)
onready var moving_state: BaseState = get_node(moving_node)
onready var timer = $Timer

onready var random = RandomNumberGenerator.new()
var timeout := false
var random_time



func _ready():
	random.randomize()
#	timer.wait_time = random.randf_range(idle_time_min, idle_time_max)
#	timer.start()



func enter() -> void:
	.enter()
	randomizeTime()
	parent_unit.velocity = Vector2.ZERO
	state_label.text = name
	print(parent_unit.name + " " + name + stepify(timer.wait_time, 0.01) as String)
	timer.start()



func physics_process(_delta: float) -> BaseState:
	if timeout:
		timeout = false
		return moving_state
	return null

#func input(event: InputEvent) -> BaseState:
#	if event.is_action_pressed("left_click"):
#		parent_unit.target = get_global_mouse_position()
##	if parent_unit.position.distance_to(parent_unit.target) > distanceCheck:
##		return moving_state
#	return null


func randomizeTime():
	random_time = stepify(random.randf_range(idle_time_min, idle_time_max), 0.01) 
	timer.set_wait_time(random_time)


func _on_Timer_timeout():
	timeout = true
