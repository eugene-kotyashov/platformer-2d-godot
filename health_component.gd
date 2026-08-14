extends Node
class_name HealthComponent

signal health_changed(current_health: float, max_health: float)
signal death

var _current : float = 100
@export var current : float = 100:
	set(value):
		if _current != value:
			_current = clampf(value, 0, max_health)
			emit_signal("health_changed", _current, max_health)
		if _current == 0:
			emit_signal("death")
	get:
		return _current

@export var max_health : float = 100

var is_alive : bool:
	get:
		return current > 0

func reset():
	current = max_health
