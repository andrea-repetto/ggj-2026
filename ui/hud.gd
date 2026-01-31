class_name HUD
extends Control

# The HUD registers itself to the global events and dispatches them to the widgets that need to be notified
@onready var mask_widget : WantedMaskWidget = $WantedMaskWidget
@onready var tension_widget : TensionLevelWidget = $TensionLevelWidget
@onready var objective_widget : ObjectiveWidget = $ObjectiveWidget

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.tension_changed.connect(handle_tension_changed)
	Global.mask_changed.connect(handle_mask_changed)
	Global.objective_changed.connect(handle_objective_changed)
	
func handle_tension_changed(in_tension: float):
	tension_widget.tension_value = in_tension
	
func handle_mask_changed(in_mask: Mask):
	mask_widget.mask = in_mask
	
func handle_objective_changed(in_name: String):
	objective_widget.display_name = in_name
