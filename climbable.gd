extends Node2D
class_name Climbable


@onready var static_body_player_shape: CollisionShape2D = $StaticBodyPlayer/CollisionShape2D


var colliding_entity: Node2D = null


func _ready() -> void:
	set_physics_process(false)


func _on_climb_area_body_entered(body: Node2D) -> void:
	body.is_colliding_with_climbable = true
	static_body_player_shape.set_deferred("disabled", true)


func _on_climb_area_body_exited(body: Node2D) -> void:
	body.is_colliding_with_climbable = false
	static_body_player_shape.set_deferred("disabled", false)


func _on_drop_through_area_body_entered(body: Node2D) -> void:
	set_physics_process(true)
	colliding_entity = body


func _on_drop_through_area_body_exited(_body: Node2D) -> void:
	set_physics_process(false)
	colliding_entity = null


func _physics_process(_delta: float) -> void:
	if colliding_entity == null: return
	
	if colliding_entity.direction.y == 1:
		static_body_player_shape.disabled = true
