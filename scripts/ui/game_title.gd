extends Label
class_name GameTitle


func _ready() -> void:
	self.set_text(ProjectSettings.get("application/config/name"))
