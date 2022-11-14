extends KinematicBody2D
class_name BaseUnits

#variable declaration and initialzation section
export (int) var speed = 200 

var velocity = Vector2.ZERO  

onready var states = $StateManager
onready var target = position

func _ready() -> void:
	states.init(self)
	

func _unhandled_input(event: InputEvent) -> void:
	states.input(event)

func _physics_process(delta: float) -> void:
	states.physics_process(delta)

func _process(delta: float) -> void:
	states.process(delta)

