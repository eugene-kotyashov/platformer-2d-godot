extends Node
class_name State

#@onready var character_body: CharacterController = $CharacteBody2D
@export var animations : AnimationComponent
@export var animation_name: StringName = &""
@export var duration_sec: float = 0
var duration_left: float = 0
@export var char_body: PhysicsComponent
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
	duration_left = duration_sec
	can_transition = false
	if animation_name == null:
		return
	if animation_name.is_empty():
		return
	if animations == null: return
	animations.play(animation_name)
	
	
func on_exit() -> void:
	animations.play("RESET")
	
