extends Control

var quick_time_button : PackedScene = preload("uid://dqr3b18t7nk8q")

func _ready() -> void:
	randomize()

func spawn_action() -> QuickTimeButton :
	var qtb : QuickTimeButton = quick_time_button.instantiate()
	add_child(qtb)
	qtb.setup_action()
	return qtb

func _on_action_spawner_timeout() -> void:
	var action : QuickTimeButton = spawn_action()
	action.error.connect(on_error)
	action.correct.connect(on_correct)
	action.missed.connect(on_missed)
	action.start_listen.connect(on_start_listen)
	action.stop_listen.connect(on_stop_listen)

func on_error():
	%BottomLight.modulate = Color.RED
	%UpLight.modulate = Color.RED

func on_correct():
	%BottomLight.modulate = Color.GREEN
	%UpLight.modulate = Color.GREEN

func on_missed():
	%BottomLight.modulate = Color.YELLOW
	%UpLight.modulate = Color.YELLOW

func on_start_listen():
	%BottomLight.modulate = Color.WHITE
	%UpLight.modulate = Color.WHITE

func on_stop_listen():
	%BottomLight.modulate = Color.WHITE
	%UpLight.modulate = Color.WHITE
