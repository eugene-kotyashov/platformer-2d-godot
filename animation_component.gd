extends Node
class_name AnimationComponent

@export var player : AnimationPlayer

func play(animation_name: StringName):
	player.play(animation_name)
