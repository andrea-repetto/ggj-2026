class_name Mask
extends Resource

@export var icon: Texture2D
@export var display_name: String

func _init(p_icon = null, p_display_name = "") -> void:
	icon = p_icon
	display_name = p_display_name
	pass
