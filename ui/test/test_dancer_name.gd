extends Node

@onready var widget_to_test : DancerNameWidget = $DancerNameWidget

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	widget_to_test.dancer_name = "Placeholder"
	var tween = get_tree().create_tween()
	tween.tween_property($DancerNameWidget, "completion", 1.0, 10).from(0.0)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
