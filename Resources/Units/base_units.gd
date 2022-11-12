extends KinematicBody2D
class_name BaseUnits

#variable declaration and initialzation section
export (int) var speed = 200 

onready var target = position
var velocity = Vector2.ZERO  








#target setting function
func _input(event): #event only happens once if held. for held commands, use Input singleton for polling.
	if event.is_action_pressed("click"): #left mouse click
		target = get_global_mouse_position() 


#unit movement function
func _physics_process(_delta): #move and slide uses delta, but we do not hand it delta so _
	velocity = position.direction_to(target) * speed 
	
	if position.distance_to(target) > 5: #distance check to target
		velocity = move_and_slide(velocity)
