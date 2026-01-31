class_name DancerNameWidget
extends Control

var dancer_name: String:
	set = _set_dancer_name
	
var completion: float:
	set = _set_completion

var letter_order: Array[int] = []

var display_text: String = ""

@onready var dancer_name_label : Label = $DancerNameLabel

func _set_dancer_name(in_name: String):
	dancer_name = in_name
	_on_name_changed()
	
func _set_completion(in_completion: float):
	completion = in_completion
	_update_display_text()
	
func _get_current_index() -> int:
	return floor(len(dancer_name) * completion) 
	
func _on_name_changed():
	letter_order = _pick_random_permutation(len(dancer_name))
	completion = 0.0

func _pick_random_permutation(in_size: int) -> Array[int]:
	var retval: Array[int] = []
	retval.resize(in_size)
	for i in range(0, in_size):
		retval[i] = i
	retval.shuffle()
	return retval

func _update_display_text():
	display_text = dancer_name
	for i in range(0, len(dancer_name)):
		var current_index : int = _get_current_index()
		if i > current_index:
			var j : int = letter_order[i]
			display_text[j] = '?'
	dancer_name_label.text = display_text

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
