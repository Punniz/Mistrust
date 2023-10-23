extends Control
class_name CreditsMenuUI


func _ready() -> void:
	for node in $VBoxContainer.get_children():
		if node is LinkButton:
			var text: String = node.get_text()
			node.set_text(text + " (Open in browser)")

