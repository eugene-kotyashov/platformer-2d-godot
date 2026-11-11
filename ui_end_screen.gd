extends CanvasLayer
class_name EndScreen
## Shared victory/defeat screen: a heading and Restart / Quit buttons over a dimmed level.

## Text shown as the heading, e.g. "YOU WIN!" or "GAME OVER".
@export var title: String = "GAME OVER"
## Seconds to wait before pausing (lets a death animation finish). 0 pauses immediately.
@export var pause_delay: float = 0.0
@export var restart_button: Button

@onready var _title_label: Label = $MarginContainer/CenterContainer/VBoxContainer/Title

func _ready() -> void:
	# Keep working while the world is paused so the buttons stay clickable.
	process_mode = Node.PROCESS_MODE_ALWAYS
	visible = false
	if _title_label != null:
		_title_label.text = title

## Shows the screen and freezes the game.
func show_screen() -> void:
	if visible:
		return
	visible = true
	if pause_delay > 0.0:
		await get_tree().create_timer(pause_delay).timeout
	get_tree().paused = true
	if restart_button != null:
		restart_button.grab_focus()

func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_quit_button_pressed() -> void:
	get_tree().quit()