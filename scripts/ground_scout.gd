extends CharacterBody2D
class_name GroundScout


@export var speed: float = 100.0

@export var direction: Vector2 = Vector2(1.0, 0.0)

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var move_track: AudioStreamPlayer2D = $MoveTrack


func _ready() -> void:
	Events.player_caught.connect(on_player_caught)


func on_player_caught() -> void:
	self.stop()


func stop() -> void:
	self.set_physics_process(false)
	move_track.stop()


func _physics_process(delta: float) -> void:
	if is_on_wall():
		self.direction.x *= -1
	
	self.velocity.x = direction.x * self.speed
	
	
	if self.direction.x == 1:
		animation_player.play("move_right")
	elif self.direction.x == -1:
		animation_player.play("move_left")
	
	self.move_and_slide()
