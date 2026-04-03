extends Node
class_name State

#@onready var character_body: CharacterController = $CharacteBody2D
@export var animations : AnimatedSprite2D
@export var animation_name: StringName = &""
@export var duration_sec: float = 0
var duration_left: float = 0
var char_body: CharacterController
var can_transition : bool = false

func update_duration(delta: float) -> void:
	duration_left -= delta
	if duration_left > 0:
		can_transition = false
	else:
		can_transition = true
		duration_left = 0
	

func update(_delta: float) -> void:
	pass

func on_enter() -> void:
	animations.play(animation_name)
	duration_left = duration_sec
	can_transition = false
	
	
func on_exit() -> void:
	pass
	
