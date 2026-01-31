class_name WantedMaskWidget
extends Control

var mask: Mask:
	set = _set_current_mask
@onready var texture : TextureRect = $TopLevelContainer/WantedMaskTexture

func _set_current_mask(in_mask: Mask):
	mask = in_mask
	_on_widget_updated()
	
func _on_widget_updated():
	texture.texture = mask.icon
	pass
