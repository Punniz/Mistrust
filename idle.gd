class_name IdleState
extends State

@export var actor: Player
@export var animator: AnimatedSprite2D

func _ready():
	set_process(true)
	
func enter_state() -> void:
	animator.play("default")
	print("in idle state")
		
func update_state() -> void:
	animator.play("default") # run is not added yet

func exit_state():
	print("exit idle state")
	pass

func _physics_process(delta): # probably can delete
	# Idle logic here
	pass
