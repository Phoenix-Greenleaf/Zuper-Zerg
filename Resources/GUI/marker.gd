extends Node2D

func _ready():
	visible = false

func _unhandled_input(event):
	if event.is_action_pressed("left_click"):
		position = get_global_mouse_position()
		if visible != true:
			visible = true
	return null
