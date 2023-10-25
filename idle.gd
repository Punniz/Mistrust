class_name IdleState
extends State


#@export var actor: Player
#
#@export var animation_tree: AnimationTree
#@onready var animation_tree_sm_playback: AnimationNodeStateMachinePlayback = animation_tree.get("parameters/playback")
@onready var animation_state_machine = animation_tree.get("parameters/playback")


func _ready():
	set_process(true)
#	print(self.name, ": animation_tree: ", animation_tree)
#	print(self.name, ": animation_node_sm : ", animation_tree_sm_playback)


func enter_state() -> void:
	#print("enter idle state")

	animation_state_machine.travel("idle")


func update_state() -> void:
#	animation_tree_sm_playback.travel("idle")
	pass


func exit_state():
	#print("exit idle state")
	pass


func _physics_process(_delta: float) -> void: # probably can delete
	# Idle logic here
	pass
