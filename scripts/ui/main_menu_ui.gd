extends Control
class_name MainMenuUI


@export var scene_to_load: PackedScene
@export var first_element_to_focus: Control


@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	assert(self.scene_to_load != null)
	assert(self.first_element_to_focus != null)
	
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_play_button_pressed() -> void:
	self.animation_player.play("play_button_pressed")


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	get_tree().change_scene_to_packed(self.scene_to_load)


func _on_visibility_changed() -> void:
	if self.visible:
		self.first_element_to_focus.call_deferred("grab_focus")
