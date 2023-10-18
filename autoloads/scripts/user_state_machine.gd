class_name UserStateMachine
extends Node

var current_state = "Idle"

func _ready():
	# Initialize the state
	change_state("Idle")

func _process(delta):
	var is_moving = Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right")
	var is_hiding = Input.is_action_pressed("move_down")

	if is_hiding and current_state != "Hide":
		change_state("Hide")
	elif is_moving and current_state != "Run":
		change_state("Run")
	elif not is_moving and not is_hiding and current_state != "Idle":
		change_state("Idle")

func change_state(new_state):
	# Exit the current state
	match current_state:
		"Idle":
			$IdleState.exit_state()
			$IdleState.set_process(false)
		"Run":
			$RunState.exit_state()
			$RunState.set_process(false)
		"Hide":
			$HideState.exit_state()
			$HideState.set_process(false)

	# Enter the new state
	match new_state:
		"Idle":
			$RunState.set_process(false)
			$HideState.set_process(false)
			$IdleState.set_process(true)
			$IdleState.enter_state()
		"Run":
			$IdleState.set_process(false)
			$HideState.set_process(false)
			$RunState.set_process(true)
			$RunState.enter_state()
		"Hide":
			$RunState.set_process(false)
			$IdleState.set_process(false)
			$HideState.set_process(true)
			$HideState.enter_state()

	current_state = new_state
