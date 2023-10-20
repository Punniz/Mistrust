class_name RunState
extends State

#@export var actor: Player
@onready var sprite_node = $"../../Sprite2D"
@onready var animation_state_machine = animation_tree.get("parameters/playback")

func _ready():
	set_process(true)

func enter_state() -> void:
	animation_state_machine.travel("run")
	pass

func exit_state() -> void:
	pass

func _physics_process(delta): 
	if actor.velocity.y != 0 and actor.is_colliding_with_climbable:
		# todo make climb state
		# exit run state go to climb state
		animation_state_machine.travel("climb") # move into climb state
	elif actor.direction.x != 0:
		animation_state_machine.travel("run")
		
	if actor.direction.x == -1: # if running left, flip the run animation horizontally
		sprite_node.scale.x = -abs(sprite_node.scale.x)
	elif actor.direction.x == 1: # if running right, put the run animation back 
		sprite_node.scale.x = abs(sprite_node.scale.x)
