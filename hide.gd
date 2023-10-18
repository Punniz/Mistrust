class_name HideState
extends State

@export var actor: Player
@export var animator: AnimatedSprite2D

func _ready():
	set_process(true)

func enter_state() -> void:
	animator.modulate = Color(0.5, 0.5, 0.5, 1)  # Darken the sprite
	print("in hide state")

func update_state() -> void:
	pass

func exit_state() -> void:
	animator.modulate = Color(1, 1, 1, 1)  # Reset to original color
	print("exit hide state")

func _physics_process(delta):
	# Hide logic here (if any)
	pass
