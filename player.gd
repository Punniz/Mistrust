class_name Player
extends CharacterBody2D


@export var speed: float = 300.0
@export var climb_speed: float = 150.0

@export var gravity: float = 200.0
@export var max_gravity: float = 1200.0

var direction: Vector2 = Vector2(0.0, 0.0)

var is_colliding_with_climbable: bool = false

var is_hiding: bool = false
var is_in_bush: bool = false


@onready var animation_tree: AnimationTree = $AnimationTree

func _ready():
	animation_tree.active = true
	Events.player_caught.connect(on_caugth)


func on_caugth() -> void:
	print(self.name, ": caught!")
#	animation_tree.get("parameters/playback").travel("caught")
	self.disable()
	$AnimationPlayer.play("caught")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "caught":
		Events.game_over.emit()
		print(self.name, ": Animation caught finished!")
	pass


func _on_animation_tree_animation_finished(_anim_name: StringName) -> void:
#	if anim_name == "caught":
#		Events.game_over.emit()
#		print(self.name, ": Animation caught finished!")
	pass


func disable() -> void:
	self.set_physics_process(false)
	self.set_process_unhandled_input(false)
	self.direction = Vector2(0.0, 0.0)
	self.velocity = Vector2(0.0, 0.0)


func _unhandled_input(_event: InputEvent) -> void:
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")


func _physics_process(_delta: float) -> void:
	if is_colliding_with_climbable:
		self.velocity.y = direction.y * climb_speed
	else:
		self.velocity.y += gravity
		if self.velocity.y >= max_gravity:
			self.velocity.y = max_gravity
	
	if self.is_on_floor():
		self.velocity.x = direction.x * self.speed
	
	self.move_and_slide()
	
#	print(self.name, ": is_hiding: ", is_hiding)
#	print(self.name, ": is_in_bush: ", is_in_bush)
