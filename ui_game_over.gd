extends CanvasLayer


@export var button: Button
@export var player: PhysicsComponent

func _on_player_health_changed(current_health: float, max_health: float):
	visible = current_health <= 0


func _on_restart_button_pressed() -> void:
	get_tree().paused = false  # Unpause first
	get_tree().reload_current_scene()  # Restarts main scene
