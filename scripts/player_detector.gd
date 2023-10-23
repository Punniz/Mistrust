extends Node2D
class_name PlayerDetector


@onready var raycasts: Node2D = $Raycasts


func _ready() -> void:
	# At least on raycast must be parented to this node!
	assert(self.raycasts.get_child_count() != 0)


func disable() -> void:
	$Area2D/CollisionPolygon2D.disabled = true
	for raycast in raycasts.get_children():
		raycast.enabled = false


func _physics_process(_delta: float) -> void:
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			if raycast.get_collider() is Player:
				self.disable()
				Events.player_caught.emit()


func _on_area_2d_body_entered(_body: Node2D) -> void:
	for raycast in raycasts.get_children():
		raycast.enabled = true


func _on_area_2d_body_exited(_body: Node2D) -> void:
	for raycast in raycasts.get_children():
		raycast.enabled = false
