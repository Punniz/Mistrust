class_name RunState
extends State

var is_paused_in_climb = false
var is_running = false
var is_climb_audio_playing = false

#@export var actor: Player
@onready var sprite_node = $"../../Sprite2D"
@onready var animation_state_machine = animation_tree.get("parameters/playback")
@onready var ray_cast = $"../../RayCast2D"
@onready var climb_audio_player = $"../../ClimbStream"

func _ready():
	set_process(true)

func enter_state() -> void:
	animation_state_machine.travel("run")
	is_paused_in_climb = false  # Reset the flag when entering this state

func exit_state() -> void:
	pass

func _physics_process(delta):
	var is_ray_hit = ray_cast.is_colliding()
	
	# Check for RayCast collision
	if is_ray_hit and actor.velocity.y == 0 and actor.velocity.x == 0 and not is_running:
		animation_state_machine.travel("idle")
		is_running = false
		# Stop climb audio when not climbing
		climb_audio_player.stop()
		# Set the flag to false
		is_climb_audio_playing = false
	
	# If climbing
	if actor.velocity.y != 0 and actor.is_colliding_with_climbable:
		animation_state_machine.travel("climb")
		actor.velocity.x = 0
		is_paused_in_climb = false
		animation_tree.active = true
		is_running = false
		
		# Play the climbing sound only if it's not already playing
		if not is_climb_audio_playing:
			climb_audio_player.play()
			is_climb_audio_playing = true  # Set the flag to true
			
	# If paused while climbing
	elif actor.velocity.y == 0 and actor.is_colliding_with_climbable and not is_running:
		if !is_paused_in_climb:  # Check the flag
			animation_tree.set("parameters/climb/current_frame", 0)  # Set to the first frame
			animation_tree.active = false  # Pause the animation
			is_paused_in_climb = true 
			is_running = false
			# Stop climb audio when paused
			climb_audio_player.stop()
			# Set the flag to false
			is_climb_audio_playing = false
			
	# If running
	elif actor.direction.x != 0:
		animation_state_machine.travel("run")
		is_paused_in_climb = false  # Reset the flag
		animation_tree.active = true  # Resume the animation
		is_running = true
		# Stop climb audio when running
		climb_audio_player.stop()
		# Set the flag to false
		is_climb_audio_playing = false
		
	# Handle sprite flipping based on direction
	if actor.direction.x == -1:  # if running left, flip the run animation horizontally
		sprite_node.scale.x = -abs(sprite_node.scale.x)
	elif actor.direction.x == 1:  # if running right, put the run animation back
		sprite_node.scale.x = abs(sprite_node.scale.x)
