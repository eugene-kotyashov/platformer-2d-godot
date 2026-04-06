extends Node2D

@onready var levelExit=$LevelExit


func _on_level_exit_area_entered(area: Area2D) -> void:
	if area.get_parent() is CharacterController:
		get_tree().paused = false  # Unpause first
		get_tree().reload_current_scene()  # Restarts main scene
