extends CharacterBody2D
class_name PhysicsComponent

@export var move_direction : float = 1

@export var gravity: Vector2 = Vector2(0, 100)
@export var health : HealthComponent
@export var state_machine : StateMachine

## Seconds of invulnerability after taking a hit.
@export var invulnerability_time: float = 0.6
## Horizontal knockback speed applied when hit.
@export var knockback_speed: float = 90.0
## Upward knockback speed applied when hit.
@export var knockback_lift: float = 40.0

var _invulnerability_left: float = 0.0

var is_invulnerable : bool:
	get:
		return _invulnerability_left > 0.0

func _physics_process(delta: float) -> void:
	_invulnerability_left = maxf(_invulnerability_left - delta, 0.0)

func _on_hurt_box_area_entered(area: Area2D) -> void:
	var hit_attack := area.get_parent() as AttackComponent
	if hit_attack == null:
		return
	if is_invulnerable:
		return
	health.current -= hit_attack.damage
	_invulnerability_left = invulnerability_time
	if health.is_alive:
		_apply_knockback(hit_attack)
		state_machine.transition(state_machine.hurt, true)
	else:
		state_machine.transition(state_machine.death, true)

func _apply_knockback(hit_attack: AttackComponent) -> void:
	var away_dir := signf(global_position.x - hit_attack.global_position.x)
	if away_dir == 0.0:
		away_dir = -move_direction
	velocity.x = away_dir * knockback_speed
	velocity.y = -knockback_lift
