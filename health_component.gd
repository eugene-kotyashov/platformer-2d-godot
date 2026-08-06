extends Node
class_name HealthComponent

signal health_changed
signal death

var _current : float
@export var current : float = 100:
	set(value):
		if _current != value:
			emit_signal("health_changed")
		_current = clampf(value, 0, max_health)
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
