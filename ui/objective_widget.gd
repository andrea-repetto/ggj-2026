class_name ObjectiveWidget
extends Control

var display_name : String:
	set = _set_display_name
	
@onready var name_label : Label = $ObjectiveTopLevelContainer/ObjectiveContainer/ObjectiveOutlinePanel/ObjectiveNameLabel

func _set_display_name(in_display_name: String):
	display_name = in_display_name
	_on_widget_updated()
	
func _on_widget_updated():
	name_label.text = display_name
	pass
