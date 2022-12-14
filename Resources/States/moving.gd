extends BaseState

export (NodePath) var state_label_node
export (NodePath) var unit_idle_node
#export (int) var moveDistanceCheck = 5
export (float) var wander_chance = 0.65
export (float) var move_time_min = 2.0
export (float) var move_time_max = 4.0
export (int) var wander_vect_dist = 6
export (float) var move_dist_check = 15.0

onready var state_label: Label = $"../../StateLabel"      # get_node(state_label_node)  # why is this line fighting me?
onready var unit_idle_state: BaseState =  get_node(unit_idle_node)
onready var random = RandomNumberGenerator.new()
onready var timer = $Timer
onready var current_motion


var wander_vector: Vector2
var min_wander_x = -wander_vect_dist
var max_wander_x = wander_vect_dist
var min_wander_y = -wander_vect_dist
var max_wander_y = wander_vect_dist
var timeout := false
var random_time


func _ready():
	random.randomize()

func enter() -> void:
	.enter()
#	timer.wait_time = random.randf_range(move_time_min, move_time_max)
	randomizeTime()
	randomizeMovement()
	randomizeVector()
	state_label.text = current_motion
	print(parent_unit.name + " " + current_motion + stepify(timer.wait_time, 0.01) as String)
#	timeout = false
	timer.start()


func randomizeMovement() -> void:
	var random_float = random.randf()
	if random_float < wander_chance:
		state_label.text = "Wandering" 
		current_motion = "Wander"
	else:
		state_label.text = "Moving"
		current_motion = "Move"



func physics_process(_delta: float) -> BaseState:
	if current_motion == "Move":
		stateMove()
	elif current_motion == "Wander":
		parent_unit.velocity = wander_vector * parent_unit.speed
	
	parent_unit.velocity = parent_unit.move_and_slide(parent_unit.velocity) #option a
#	wander_vector = parent_unit.move_and_slide(parent_unit.velocity) # option b maybe more deflection? 
		
	if timeout:
		timeout = false
		return unit_idle_state
	return null

func stateMove():

	if parent_unit.position.distance_to(parent_unit.target) < move_dist_check:	#added off camera
		parent_unit.velocity = Vector2.ZERO
	else:
		parent_unit.velocity = parent_unit.position.direction_to(parent_unit.target) * parent_unit.speed


func randomizeTime():
	random_time = stepify(random.randf_range(move_time_min, move_time_max), 0.01) 
	timer.set_wait_time(random_time)


func randomizeVector():
	wander_vector.x = random.randi_range(min_wander_x, max_wander_x)
	wander_vector.y = random.randi_range(min_wander_y, max_wander_y)
	wander_vector = wander_vector.normalized()


func _on_Timer_timeout():
	timeout = true
