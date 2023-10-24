extends Area2D
class_name HidingSpot


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.is_in_bush = true


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		body.is_in_bush = false
