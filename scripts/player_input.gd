class_name PlayerInput
extends Node


var direction: Vector2
var animation_to_play: String
var flip_h: bool


func _process(delta: float) -> void:
	direction = Vector2(
			Input.get_axis("walk_left", "walk_right"),
			Input.get_axis("walk_up", "walk_down")
	).normalized()
	
	if direction.x < -0.8:
		flip_h = true
		animation_to_play = "WALK_SIDE"
	if direction.x > 0.8:
		flip_h = false
		animation_to_play = "WALK_SIDE"
	if direction == Vector2.ZERO:
		animation_to_play = "IDLE"
	if direction.y > 0.8:
		animation_to_play = "WALK_UP"
	if direction.y < -0.8:
		animation_to_play = "WALK_DOWN"
