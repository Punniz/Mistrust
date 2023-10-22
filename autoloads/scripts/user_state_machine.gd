class_name UserStateMachine
extends Node


enum States {
	IDLE,
	RUN,
	CLIMB,
	HIDE
}

var current_state: States = States.IDLE


func _ready() -> void:
	# Initialize the state
	change_state(States.IDLE)


func _unhandled_input(event: InputEvent) -> void:
	var is_moving: bool = Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right")
	var is_hiding: bool = Input.is_action_pressed("interact")
	if Input.is_action_just_released("move_left") or Input.is_action_just_released("move_right") and Input.is_action_pressed("interact"):
		change_state(States.HIDE)
	if is_hiding and current_state != States.HIDE:
		change_state(States.HIDE)
	elif is_moving and current_state != States.RUN:
		change_state(States.RUN)
	elif not is_moving and not is_hiding and current_state != States.IDLE:
		change_state(States.IDLE)


@export var idle_state_node: IdleState
@export var run_state_node: RunState
@export var hide_state_node: HideState


func change_state(new_state: States) -> void:
	# Exit the current state
	match current_state:
		States.IDLE:
			idle_state_node.exit_state()
			idle_state_node.set_process(false)
		States.RUN:
			run_state_node.exit_state()
			run_state_node.set_process(false)
		States.HIDE:
			hide_state_node.exit_state()
			hide_state_node.set_process(false)

	# Enter the new state
	match new_state:
		States.IDLE:
			run_state_node.set_process(false)
			hide_state_node.set_process(false)
			idle_state_node.set_process(true)
			idle_state_node.enter_state()
		States.RUN:
			idle_state_node.set_process(false)
			hide_state_node.set_process(false)
			run_state_node.set_process(true)
			run_state_node.enter_state()
		States.HIDE:
			run_state_node.set_process(false)
			idle_state_node.set_process(false)
			hide_state_node.set_process(true)
			hide_state_node.enter_state()

	current_state = new_state
