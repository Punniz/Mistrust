extends Control
class_name PauseMenu


@onready var resume_button: Button = $Panel/VBoxContainer/ResumeButton


func _ready() -> void:
	self.hide()


func _on_visibility_changed() -> void:
	if self.visible:
		get_tree().paused = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		get_tree().paused = false
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _on_resume_button_pressed() -> void:
	self.hide()


func _unhandled_key_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_pause"):
		if self.visible:
			self.hide()
		else:
			self.show()
			self.resume_button.call_deferred("grab_focus")
