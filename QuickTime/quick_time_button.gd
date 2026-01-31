extends Control
class_name QuickTimeButton

var current_action : String
var total_time : float = 5.0
var buffer : float = 0.3
var listen_input : bool = false
var offset : float = 300
var has_pressed : bool = false
var action_strings : Dictionary[String, CompressedTexture2D] = {
	"dance_A" : preload("uid://bniamxxsfipyg"),
	"dance_B" : preload("uid://ww40lfpoafqh"),
	"dance_X" : preload("uid://dq7ypxhljiru1"),
	"dance_Y" : preload("uid://cee2ruk2v0kvq")
}

signal correct
signal error
signal missed
signal start_listen
signal stop_listen

func setup_action() :
	var picked_action : String = action_strings.keys().pick_random()
	%TextureRect.texture = action_strings[picked_action]
	current_action = picked_action
	position.x = position.x + offset
	var tween : Tween = create_tween()
	tween.tween_property(self, "position:x", -offset, total_time)
	tween.parallel().tween_property(self, "modulate:a", 1, total_time/2)
	tween.finished.connect(queue_free)
	_start_listen()
	_stop_listen()

func _input(event: InputEvent) -> void:
	if current_action.is_empty() :
		return
	if event.is_action(current_action) && listen_input:
		correct.emit()
		current_action = ""
		has_pressed = true
		return
	for a : String in action_strings.keys() :
		if event.is_action(a) && listen_input: 
			error.emit()
			current_action = ""
			has_pressed = true
			listen_input = false
			return

func _start_listen():
	await get_tree().create_timer(total_time/2 - buffer).timeout
	listen_input = true
	start_listen.emit()

func _stop_listen():
	await get_tree().create_timer(total_time/2 + buffer).timeout
	listen_input = false
	stop_listen.emit()
	var tween : Tween = create_tween()
	tween.parallel().tween_property(self, "modulate:a", 0, total_time/2)
	if !has_pressed:
		missed.emit()
