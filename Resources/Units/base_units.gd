extends KinematicBody2D
class_name BaseUnits

#variable declaration and initialzation section
export (int) var speed = 200 

onready var target = position
var velocity = Vector2.ZERO  

onready var states = $StateManager

func _ready() -> void:
	states.init(self)

func _unhandled_input(event: InputEvent) -> void:
	states.input(event)

func _physics_process(delta: float) -> void:
	states.physics_process(delta)

func _process(delta: float) -> void:
	states.process(delta)






"""

Code to move down to states, off of individual units





#unit movement function
func _physics_process(_delta): #move and slide uses delta, but we do not hand it delta so _
	velocity = position.direction_to(target) * speed 
	
	if position.distance_to(target) > 5: #distance check to target
		velocity = move_and_slide(velocity)


"""
