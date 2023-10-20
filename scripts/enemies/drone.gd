extends PathFollow2D
class_name Drone


@export var speed: float = 300.0


func _ready() -> void:
	assert(self.get_parent() is Path2D)


func _physics_process(delta: float) -> void:
	if progress_ratio == 0 or progress_ratio == 1:
		speed = -speed
	
	progress += speed * delta
