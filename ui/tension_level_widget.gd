class_name TensionLevelWidget
extends Control

var tension_value : float:
	set = _set_tension
	
@onready var tension_progress : TextureProgressBar = $TensionLevel_TopLevelContainer/TensionLevel_Container/TensionLevel_Progress

func _set_tension(in_tension: float):
	tension_value = in_tension
	_on_widget_updated()

func _on_widget_updated():
	tension_progress.value = tension_value
	pass
