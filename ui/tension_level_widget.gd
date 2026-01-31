class_name TensionLevelWidget
extends Control

var tension_value : float:
	set = _set_tension
	
@onready var tension_progress_widget : TextureProgressBar = $TopLevelContainer/Progress

func _set_tension(in_tension: float):
	tension_value = in_tension
	_on_widget_updated()

func _on_widget_updated():
	tension_progress_widget.value = tension_value
	pass
