extends CharacterBody2D
class_name GroundScout


@export var speed: float = 100.0

@export var direction: Vector2 = Vector2(1.0, 0.0)

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _physics_process(delta: float) -> void:
	if is_on_wall():
		self.direction.x *= -1
	
	self.velocity.x = direction.x * self.speed
	
	
	if self.direction.x == 1:
		animation_player.play("move_right")
	elif self.direction.x == -1:
		animation_player.play("move_left")
	
	self.move_and_slide()
