extends Label
class_name VersionLabel


func _ready() -> void:
	self.set_text("Version: " + ProjectSettings.get("application/config/version"))
