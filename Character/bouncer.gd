extends Node2D

var tension_on_bounce : float = 10.0

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Bounceable"):
		body.knockback(position)
		Global.update_tension(tension_on_bounce)
