# Handles what the protagonist should be doing when the character is waiting for user input. -Jeff
class_name IdleState
extends State

@onready var animation_state_machine = animation_tree.get("parameters/playback")

func _ready():
	set_process(true)

# Similarly, you could have methods for other animations
func set_run_animation():
	animation_state_machine.travel("run")

func enter_state():
	animation_state_machine.travel("idle")
	
func exit_state():
	pass
