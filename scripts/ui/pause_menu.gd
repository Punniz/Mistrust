extends Control
class_name PauseMenu


@onready var resume_button: Button = $Panel/VBoxContainer/ResumeButton


func _ready() -> void:
	self.hide()
	
	Events.player_caught.connect(on_player_caught)


func on_player_caught() -> void:
	set_process_unhandled_key_input(false)


func _on_visibility_changed() -> void:
	if self.visible:
		get_tree().set_deferred("paused", true)
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		get_tree().set_deferred("paused", false)
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _on_resume_button_pressed() -> void:
	self.hide()


func _unhandled_key_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_pause"):
		if self.visible:
			self.hide()
		else:
			self.show()
			self.resume_button.call_deferred("grab_focus")
