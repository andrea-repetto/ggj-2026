extends RichTextLabel
class_name InstructionText

var is_active : bool = false

func send_message(new_text : String) :
	if is_active :
		return
	is_active = true
	scale = Vector2.ZERO
	modulate.a = 0
	text = "[wave amp=50.0 freq=5.0 connected=1]" + new_text + "[/wave]"
	var t : Tween = create_tween()
	t.tween_property(self, "scale", Vector2.ONE, 2.0)
	t.parallel().tween_property(self, "modulate:a", 1.0, 1.0)
	t.chain().tween_property(self, "scale", Vector2.ONE, 5.0)
	t.chain().tween_property(self, "modulate:a", 0.0, 1.0) 
	t.chain().tween_property(self, "scale", Vector2.ZERO, 0.2)
	t.finished.connect(func(): is_active = false)
