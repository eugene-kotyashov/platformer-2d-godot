extends Node
class_name State

#@onready var character_body: CharacterController = $CharacteBody2D
@export var animations : AnimatedSprite2D
@export var animation_name: StringName = &""
@export var char_body: CharacterController

func update(_delta: float) -> void:
	pass

func on_enter() -> void:
	animations.play(animation_name)
	
func on_exit() -> void:
	pass
	
