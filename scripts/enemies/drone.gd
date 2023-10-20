extends PathFollow2D
class_name Drone


@export var speed: float = 300.0


@onready var raycasts: Node2D = $Raycasts


func _ready() -> void:
	assert(self.get_parent() is Path2D)


func _physics_process(delta: float) -> void:
	if progress_ratio == 0 or progress_ratio == 1:
		speed = -speed
	
	progress += speed * delta
	
	
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			# Player caught, need to handle game over
			if raycast.get_collider() is Player:
				print("Colliding with player: ", raycast.get_collider())
			# Debug only, remove when done
			else:
				print("Colliding but not with player: ", raycast.get_collider())


func _on_area_2d_body_entered(body: Node2D) -> void:
	for raycast in raycasts.get_children():
		raycast.enabled = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	for raycast in raycasts.get_children():
		raycast.enabled = false
