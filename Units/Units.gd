""" How exciting! My first game "class". This is the base for other units, and 

"""

extends KinematicBody2D

#variable declaration and initialzation section
export (int) var speed = 200 #just a variable but also exported to the editor inspector

onready var target = position # current spot is destination upon initialization
var velocity = Vector2.ZERO  # no movement when started








#target setting function
func _input(event): #event only happens once if held. for held commands, use Input singleton for polling.
	if event.is_action_pressed("click"): #if left mouse clicked
		target = get_global_mouse_position() #set the target to the mouse position


#unit movement function
func _physics_process(_delta): #move and slide uses delta, but we do not hand it delta so _
	velocity = position.direction_to(target) * speed 
	
	if position.distance_to(target) > 5: #distance check to target
		velocity = move_and_slide(velocity)
