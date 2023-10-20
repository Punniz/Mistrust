class_name Player
extends CharacterBody2D


@export var speed: float = 300.0
@export var climb_speed: float = 150.0

@export var gravity: float = 200.0
@export var max_gravity: float = 1200.0

var direction: Vector2 = Vector2(0.0, 0.0)

var is_colliding_with_climbable: bool = false

var is_hiding: bool = false


@onready var animation_tree: AnimationTree = $AnimationTree

func _ready():
	animation_tree.active = true
	pass


func _unhandled_input(event: InputEvent) -> void:
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")


func _physics_process(delta: float) -> void:
	if is_colliding_with_climbable:
		self.velocity.y = direction.y * climb_speed
	else:
		self.velocity.y += gravity
		if self.velocity.y >= max_gravity:
			self.velocity.y = max_gravity
	
	if self.is_on_floor():
		self.velocity.x = direction.x * self.speed
	
	self.move_and_slide()
