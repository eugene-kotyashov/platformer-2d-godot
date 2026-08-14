extends Node
class_name State

#@onready var character_body: CharacterController = $CharacteBody2D
@export var animations : AnimationComponent
@export var animation_name: StringName = &""
@export var duration_sec: float = 0
var duration_left: float = 0
var can_transition : bool :
	get:
		return duration_left <= 0
var char_body: PhysicsComponent

func update_duration(delta: float) -> void:
	duration_left -= delta
	

func update(_delta: float) -> void:
	pass

func on_enter() -> void:
	duration_left = duration_sec
	if animation_name == null:
		return
	if animation_name.is_empty():
		return
	if animations == null: return
	animations.play(animation_name)
	
	
func on_exit() -> void:
	animations.play("RESET")
	print("reset played")
	
