class_name RunState
extends State

var is_paused_in_climb = false

#@export var actor: Player
@onready var sprite_node = $"../../Sprite2D"
@onready var animation_state_machine = animation_tree.get("parameters/playback")

func _ready():
	set_process(true)

func enter_state() -> void:
	animation_state_machine.travel("run")
	is_paused_in_climb = false  # Reset the flag when entering this state

func exit_state() -> void:
	pass

func _physics_process(delta):
	# If climbing
	if actor.velocity.y != 0 and actor.is_colliding_with_climbable:
		animation_state_machine.travel("climb")
		is_paused_in_climb = false  # Reset the flag
		animation_tree.active = true  # Resume the animation
	# If paused while climbing
	elif actor.velocity.y == 0 and actor.is_colliding_with_climbable:
		if !is_paused_in_climb:  # Check the flag
			animation_tree.set("parameters/climb/current_frame", 0)  # Set to the first frame
			animation_tree.active = false  # Pause the animation
			is_paused_in_climb = true  # Set the flag
	# If running
	elif actor.direction.x != 0:
		animation_state_machine.travel("run")
		is_paused_in_climb = false  # Reset the flag
		animation_tree.active = true  # Resume the animation
		
	# Handle sprite flipping based on direction
	if actor.direction.x == -1:  # if running left, flip the run animation horizontally
		sprite_node.scale.x = -abs(sprite_node.scale.x)
	elif actor.direction.x == 1:  # if running right, put the run animation back
		sprite_node.scale.x = abs(sprite_node.scale.x)
