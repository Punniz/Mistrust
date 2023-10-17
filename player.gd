extends CharacterBody2D
class_name Player


@export var speed: float = 300.0

@export var gravity: float = 200.0
@export var max_gravity: float = 1200.0


func _unhandled_input(event: InputEvent) -> void:
	var input_direction_x: float = Input.get_axis("move_left", "move_right")
	var input_direction_y: float = Input.get_axis("move_up", "move_down")
	
	self.velocity.x = input_direction_x * self.speed


func _physics_process(delta: float) -> void:
	self.velocity.y += gravity
	if self.velocity.y >= max_gravity:
		self.velocity.y = max_gravity
		
	self.move_and_slide()
	
	print("velocity: ", velocity)
