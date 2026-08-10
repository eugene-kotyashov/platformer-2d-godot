extends Node2D
class_name VisualsComponent


@export var sprites : Sprite2D

func change_move_dir(new_direction : float) :
	if new_direction > 0:
		sprites.flip_h = false
	else:
		sprites.flip_h = true

	
