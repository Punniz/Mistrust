class_name RunState
extends State


@export var actor: Player
@export var animator: AnimatedSprite2D

func _ready():
	set_process(true)
	animator.pause() # run is not added yet
	

func enter_state() -> void:
	animator.pause()
	print("in run state")
		
func exit_state() -> void:
	print("exit run state")
	pass

func _physics_process(delta): # probably can delete
	pass
