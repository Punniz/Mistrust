class_name HideState
extends State


#@export var actor: Player
@onready var animation_state_machine = animation_tree.get("parameters/playback")
@onready var hide_audio_player = $"../../HideStream"
@onready var reveal_audio_player = $"../../RevealStream"


func _ready():
	set_process(true)

func enter_state() -> void:
#	animator.modulate = Color(0.5, 0.5, 0.5, 1)  # Darken the sprite
	hide_audio_player.play()
	animation_state_machine.travel("hide")
	#print("in hide state")

func update_state() -> void:
	pass

func exit_state() -> void:
#	animator.modulate = Color(1, 1, 1, 1)  # Reset to original color
	reveal_audio_player.play()
	animation_state_machine.travel("reveal")
	#print("exit hide state")

func _physics_process(_delta) -> void:
	# Hide logic here (if any)
	pass
