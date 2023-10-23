extends Path2D
class_name Drone


@export var speed: float = 100.0


@onready var path_follow: PathFollow2D = $PathFollow2D


func _ready() -> void:
	Events.player_caught.connect(on_player_caught)


func on_player_caught() -> void:
	self.stop()


func stop() -> void:
	self.set_physics_process(false)


func _physics_process(delta: float) -> void:
	if path_follow.progress_ratio == 0 or path_follow.progress_ratio == 1:
		speed = -speed
	
	path_follow.progress += speed * delta
