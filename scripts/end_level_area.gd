extends Node2D
class_name EndLevelArea2D


@export var level_finished_scene: PackedScene

func _on_body_entered(body: Node2D) -> void:
	Events.player_finished_level.emit()
	get_tree().change_scene_to_packed(level_finished_scene)
