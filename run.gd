class_name RunState
extends State

var is_paused_in_climb = false
var is_running = false
var is_climb_audio_playing = false
var is_idle = false  # Add this flag to identify when the actor is idle

#@export var actor: Player
@onready var sprite_node = $"../../Sprite2D"
@onready var animation_state_machine = animation_tree.get("parameters/playback")
@onready var ray_cast = $"../../RayCast2D"
@onready var climb_audio_player = $"../../ClimbStream"
@onready var wood_audio_player = $"../../WoodRunStream"
@onready var grass_audio_player = $"../../GrassRunStream"

func _ready():
	set_process(true)

func enter_state() -> void:
	animation_state_machine.travel("run")
	is_paused_in_climb = false  # Reset the flag when entering this state

func exit_state() -> void:
	pass

func _physics_process(delta):
	var is_ray_hit = ray_cast.is_colliding()
	
	if actor.velocity.x == 0 and actor.velocity.y == 0:
		is_idle = true  # Set the flag to true when idle
	else:
		is_idle = false  # Set the flag to false otherwise
	
	if actor.velocity.x == 0:
		if wood_audio_player.is_playing():
			wood_audio_player.stop()
		if grass_audio_player.is_playing():
			grass_audio_player.stop()
	
	if is_ray_hit:
		var collider = ray_cast.get_collider()
		print(collider.name)
		if "wood" in collider.name and is_running and not is_idle:  # Added not is_idle
			grass_audio_player.stop()  # Stop grass audio if it's playing
			if not wood_audio_player.is_playing():
				wood_audio_player.play()
		elif "grass" in collider.name and is_running and not is_idle:  # Added not is_idle
			wood_audio_player.stop()  # Stop wood audio if it's playing
			if not grass_audio_player.is_playing():
				grass_audio_player.play()
	
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
