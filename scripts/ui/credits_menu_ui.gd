extends Control
class_name CreditsMenuUI


@export var first_element_to_focus: Control

func _ready() -> void:
	for node in $VBoxContainer.get_children():
		if node is LinkButton:
			var text: String = node.get_text()
			node.set_text(text + " (Open in browser)")


func _on_visibility_changed() -> void:
	if self.visible:
		self.first_element_to_focus.call_deferred("grab_focus")
