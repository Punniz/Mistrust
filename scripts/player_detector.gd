extends Node2D
class_name PlayerDetector


@onready var raycasts: Node2D = $Raycasts


func _ready() -> void:
	# At least on raycast must be parented to this node!
	assert(self.raycasts.get_child_count() != 0)


func _physics_process(delta: float) -> void:
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			# Player caught, need to handle GAME OVER
			if raycast.get_collider() is Player:
#				print("Colliding with player: ", raycast.get_collider())
				pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	for raycast in raycasts.get_children():
		raycast.enabled = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	for raycast in raycasts.get_children():
		raycast.enabled = false
