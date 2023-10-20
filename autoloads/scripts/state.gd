class_name State
extends Node


@export var actor: Player

@export var animation_tree: AnimationTree
@onready var animation_tree_sm_playback: AnimationNodeStateMachinePlayback# = animation_tree.get("parameters/playback")


signal state_finished


func _enter_state() -> void:
	pass
	
	
func _exit_state() -> void:
	pass
