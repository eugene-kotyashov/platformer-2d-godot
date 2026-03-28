extends Node
class_name State

#@onready var character_body: CharacterController = $CharacteBody2D
@export var animations : AnimatedSprite2D
@export var animation_name: StringName = &""
@export var duration_sec: float = 0
var char_body: CharacterController
var duration_timer: Timer
var can_transition : bool = true

func update(_delta: float) -> void:
	pass

func on_enter() -> void:
	animations.play(animation_name)
	if duration_sec > 0:
		can_transition = false
		await get_tree().create_timer(duration_sec).timeout
		can_transition = true
	
	
func on_exit() -> void:
	pass
	
