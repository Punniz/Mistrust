extends Control
class_name LevelFinishedMenu


@export var scene_to_load_file_path: String = "res://scenes/main_menu_world.tscn"
@export var first_element_to_focus: Button


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_file(scene_to_load_file_path)


func _on_quit_to_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file(scene_to_load_file_path)


func _on_visibility_changed() -> void:
	if self.visible:
		self.first_element_to_focus.call_deferred("grab_focus")
		$MusicTrack.call_deferred("play")
