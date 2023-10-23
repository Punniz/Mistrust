class_name HideState
extends State


#@export var actor: Player
@onready var animation_state_machine = animation_tree.get("parameters/playback")

func _ready():
	set_process(true)

func enter_state() -> void:
#	animator.modulate = Color(0.5, 0.5, 0.5, 1)  # Darken the sprite

	animation_state_machine.travel("hide")
	#print("in hide state")

func update_state() -> void:
	pass

func exit_state() -> void:
#	animator.modulate = Color(1, 1, 1, 1)  # Reset to original color
	
	animation_state_machine.travel("reveal")
	#print("exit hide state")

func _physics_process(delta):
	# Hide logic here (if any)
	pass
