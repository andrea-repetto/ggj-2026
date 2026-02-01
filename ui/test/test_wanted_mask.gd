extends Node2D

@onready var widget_to_test = $WantedMaskWidget

var current_index = 0

const Masks = [
	"res://mask/mask_01.tres",
	"res://mask/mask_02.tres",
	"res://mask/mask_03.tres"
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.one_shot = false
	$Timer.timeout.connect(_on_timer_expired)
	$Timer.start(3.0)
	widget_to_test.mask = get_mask(0)

func get_mask(index: int) -> Mask:
	return load(Masks[current_index]) as Mask


func _on_timer_expired() -> void:
	current_index = (current_index + 1) % len(Masks)
	widget_to_test.mask = get_mask(current_index)
	pass
