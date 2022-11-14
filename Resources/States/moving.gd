extends BaseState

export (NodePath) var state_label_node
export (NodePath) var unit_idle_node
#export (int) var moveDistanceCheck = 5
export (float) var wander_chance = 0.65
export (float) var move_time_min = 2.0
export (float) var move_time_max = 5.0
export (int) var wander_vect_dist = 6

onready var state_label: Label = $"../../StateLabel"      # get_node(state_label_node)  # why is this line fighting me?
onready var unit_idle_state: BaseState =  get_node(unit_idle_node)
onready var random = RandomNumberGenerator.new()
onready var timer = $MovingTimer
onready var current_motion = movementRandomness()


onready var wander_vector: Vector2 = Vector2(random.randi_range(min_wander_x, max_wander_x), \
	random.randi_range(min_wander_y, max_wander_y))  # the \ should make this multi-line ok

var min_wander_x = -wander_vect_dist
var max_wander_x = wander_vect_dist
var min_wander_y = -wander_vect_dist
var max_wander_y = wander_vect_dist




#func enter() -> void:
#	.enter()
#	state_label.text = name
	
func ready():
	random.randomize()
	timer.time_left = random.randf_range(move_time_min, move_time_max)
	print(parent_unit.name + " " + current_motion + timer.time_left)
	print( "X " +min_wander_x + " " + max_wander_x + " Y " + min_wander_y + " " + max_wander_y)
	timer.start()


func movementRandomness() -> String:
	var random_float = random.randf()
	if random_float < wander_chance:
		state_label.text = "Wandering" 
		return "wander"
	else:
		state_label.text = "Moving"
		return "move"



func physics_process(_delta: float) -> BaseState:
	if current_motion == "move":
		parent_unit.velocity = parent_unit.position.direction_to(parent_unit.target) * parent_unit.speed
	elif current_motion == "wander":
		parent_unit.velocity = wander_vector.normalized() * parent_unit.speed
	parent_unit.velocity = parent_unit.move_and_slide(parent_unit.velocity) #option a
#	wander_vector = parent_unit.move_and_slide(parent_unit.velocity) # option b maybe more deflection? 
	return null


func _on_MovingTimer_timeout() -> BaseState:
	return unit_idle_state
