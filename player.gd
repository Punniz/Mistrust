extends CharacterBody2D
class_name Player


@export var speed: float = 300.0

@export var gravity: float = 200.0
@export var max_gravity: float = 1200.0


var is_colliding_with_climbable: bool = false

var input_direction_x: float = 0.0
var input_direction_y: float = 0.0

func _unhandled_input(event: InputEvent) -> void:
	input_direction_x = Input.get_axis("move_left", "move_right")
	input_direction_y = Input.get_axis("move_up", "move_down")

var climb_speed: float = 150.0

func _physics_process(delta: float) -> void:
	if is_colliding_with_climbable:
		self.velocity.y = input_direction_y * climb_speed
	else:
		self.velocity.y += gravity
		if self.velocity.y >= max_gravity:
			self.velocity.y = max_gravity
	
	if self.is_on_floor():
		self.velocity.x = input_direction_x * self.speed
	
	self.move_and_slide()
	
	print("velocity: ", velocity)
