extends Path2D
class_name Drone


@export var speed: float = 100.0


@onready var path_follow: PathFollow2D = $PathFollow2D


func _physics_process(delta: float) -> void:
	if path_follow.progress_ratio == 0 or path_follow.progress_ratio == 1:
		speed = -speed
	
	path_follow.progress += speed * delta
