extends Control
class_name Cutscene


@export var scene_to_load: PackedScene

@onready var video_stream_player: VideoStreamPlayer = $VideoStreamPlayer


func _ready() -> void:
	assert(self.scene_to_load != null)
	
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	self.video_stream_player.play()


func _on_video_stream_player_finished() -> void:
	get_tree().change_scene_to_packed(self.scene_to_load)


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_packed(self.scene_to_load)
