extends Node
## Unit tests for the platformer's reusable components.
## Run with Ziva's test runner (run_tests) or execute_script.

const HealthComponentScript := preload("res://health_component.gd")
const StateMachineScript := preload("res://state_machine.gd")

func _make_health() -> HealthComponent:
	var health: HealthComponent = HealthComponentScript.new()
	add_child(health)
	return health

func _make_state_machine() -> StateMachine:
	var sm: StateMachine = StateMachineScript.new()
	add_child(sm)
	return sm

func test_health_starts_alive_at_max() -> void:
	var health := _make_health()
	health.max_health = 100.0
	health.reset()
	assert(health.current == 100.0)
	assert(health.is_alive)
	health.free()

func test_health_damage_clamps_and_reports_death() -> void:
	var health := _make_health()
	health.max_health = 100.0
	health.reset()
	var death_count: Array = [0]
	health.death.connect(func() -> void: death_count[0] += 1)
	health.current -= 30.0
	assert(health.current == 70.0)
	assert(health.is_alive)
	health.current -= 100.0
	assert(health.current == 0.0)
	assert(not health.is_alive)
	assert(death_count[0] == 1)
	health.free()

func test_health_changed_signal_only_on_change() -> void:
	var health := _make_health()
	health.max_health = 100.0
	health.reset()
	var events: Array = []
	health.health_changed.connect(
		func(cur: float, maxv: float) -> void: events.append([cur, maxv]))
	health.current = 50.0
	assert(events.size() == 1)
	assert(events[0][0] == 50.0 and events[0][1] == 100.0)
	health.current = 50.0
	assert(events.size() == 1)
	health.free()

func test_state_machine_transition_and_duration_gate() -> void:
	var sm := _make_state_machine()
	var a := State.new()
	var b := State.new()
	a.name = "a"
	b.name = "b"
	sm.add_child(a)
	sm.add_child(b)
	sm.current_state = a
	sm.transition(b)
	assert(sm.current_state == b)
	sm.transition(b)
	assert(sm.current_state == b)

	a.duration_sec = 1.0
	a.on_enter()
	sm.current_state = a
	sm.transition(b)
	assert(sm.current_state == a)
	sm.transition(b, true)
	assert(sm.current_state == b)
	sm.free()

func test_physics_component_invulnerability_timer() -> void:
	var physics := PhysicsComponent.new()
	add_child(physics)
	physics._invulnerability_left = 0.5
	assert(physics.is_invulnerable)
	physics._physics_process(0.5)
	assert(not physics.is_invulnerable)
	physics.free()