extends Node2D
class_name Climbable


func _on_area_2d_body_entered(body: Node2D) -> void:
	body.is_colliding_with_climbable = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	body.is_colliding_with_climbable = false
