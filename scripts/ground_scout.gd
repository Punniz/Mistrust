extends CharacterBody2D
class_name GroundScout


@export var speed: float = 100.0

@export var direction: Vector2 = Vector2(1.0, 0.0)


@onready var obstacle_detector: RayCast2D = $ObstacleDetector

func _physics_process(delta: float) -> void:
	self.velocity.x = direction.x * self.speed
	
	if obstacle_detector.is_colliding():
		self.direction.x = -1
	
	self.move_and_slide()
