extends CanvasLayer

@export var player: CharacterController
@export var health_bar: ProgressBar

func _on_player_health_changed():
	if health_bar:
		health_bar.value = 100* player.health / player.max_health
	# print("ui: health changed")
