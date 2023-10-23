class_name RunState
extends State

var is_paused_in_climb = false
var is_running = false
var is_climb_audio_playing = false
var is_idle = false  # Flag to identify when the actor is idle

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
	
	# Check if the actor is idle
	is_idle = actor.velocity.x == 0 and actor.velocity.y == 0
	
	# Stop wood and grass audio if actor is not moving
	if is_idle:
		wood_audio_player.stop()
		grass_audio_player.stop()
	
	# Audio handling based on surface
	if is_ray_hit:
		var collider = ray_cast.get_collider()

		if "wood" in collider.name and is_running and not is_idle:
			grass_audio_player.stop()
			if not wood_audio_player.is_playing():
				wood_audio_player.play()
		elif "grass" in collider.name and is_running and not is_idle:
			wood_audio_player.stop()
			if not grass_audio_player.is_playing():
				grass_audio_player.play()
	
	# State handling for various actions
	if is_ray_hit and actor.velocity.y == 0 and actor.velocity.x == 0 and not is_running:
		animation_state_machine.travel("idle")
		is_running = false
		climb_audio_player.stop()
		is_climb_audio_playing = false
	
	# Enter climb 
	if actor.velocity.y != 0 and actor.is_colliding_with_climbable:
		animation_state_machine.travel("climb")
		actor.velocity.x = 0
		is_paused_in_climb = false
		animation_tree.active = true
		is_running = false
		
		# Stop grass and wood audio players when climbing
		grass_audio_player.stop()
		wood_audio_player.stop()
		
		if not is_climb_audio_playing:
			climb_audio_player.play()
			is_climb_audio_playing = true
			
	elif actor.velocity.y == 0 and actor.is_colliding_with_climbable and not is_running:
		if !is_paused_in_climb:
			animation_tree.set("parameters/climb/current_frame", 0)
			animation_tree.active = false
			is_paused_in_climb = true
			climb_audio_player.stop()
			is_climb_audio_playing = false
	
	elif actor.direction.x != 0:
		animation_state_machine.travel("run")
		is_paused_in_climb = false
		animation_tree.active = true
		is_running = true
		climb_audio_player.stop()
		is_climb_audio_playing = false
	
	# Sprite flipping
	if actor.direction.x == -1:
		sprite_node.scale.x = -abs(sprite_node.scale.x)
	elif actor.direction.x == 1:
		sprite_node.scale.x = abs(sprite_node.scale.x)
