extends Node2D

@onready var widget_to_test = $TensionLevelWidget

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(widget_to_test, "tension_value", 100.0, 10).from(0.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
