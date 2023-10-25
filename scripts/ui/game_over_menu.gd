extends Control
class_name GameOverMenu


@export var first_element_to_focus: Button

@onready var game_over_stinger_track: AudioStreamPlayer = $GameOverStingerTrack
@onready var game_over_loop_track: AudioStreamPlayer = $GameOverLoopTrack

var main_menu_file_path: String = "res://scenes/ui/main_menu_ui.tscn"
var world_scene_file_path: String = "res://world.tscn"


func _ready() -> void:
	Events.game_over.connect(on_game_over)


func on_game_over() -> void:
	self.show()
	game_over_stinger_track.play()
	game_over_loop_track.play()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_retry_button_pressed() -> void:
	get_tree().change_scene_to_file(world_scene_file_path)


func _on_quit_to_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file(main_menu_file_path)


func _on_visibility_changed() -> void:
	if self.visible:
		self.first_element_to_focus.call_deferred("grab_focus")
