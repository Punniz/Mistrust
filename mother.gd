extends CharacterBody2D


@export var speed: float = 500.0

@export var direction: Vector2 = Vector2(1.0, 0.0)



func _ready() -> void:
	Events.player_caught.connect(on_player_caught)
	$AnimatedSprite2D.play()

func on_player_caught() -> void:
	self.stop()


func stop() -> void:
	self.set_physics_process(false)


func _physics_process(_delta: float) -> void:
	if is_on_wall():
		self.direction.x *= -1
	
	self.velocity.x = direction.x * self.speed
	
	self.move_and_slide()
