extends Node
#class_name Settings


var dev_base_resolution: Vector2i = Vector2i(1280, 720)


func _ready() -> void:
	TranslationServer.set_locale(OS.get_locale())
	
	if OS.is_debug_build():
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_size(self.dev_base_resolution)
