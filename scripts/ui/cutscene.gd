extends Control
class_name Cutscene


@export var scene_to_load: PackedScene

@onready var video_stream_player: VideoStreamPlayer = $VideoStreamPlayer
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	assert(self.scene_to_load != null)
	
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "end":
		get_tree().change_scene_to_packed(self.scene_to_load)


func _on_video_stream_player_finished() -> void:
	self.transition_to_next_scene()


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_cancel"):
		self.transition_to_next_scene()


func transition_to_next_scene() -> void:
	self.animation_player.play("end")
