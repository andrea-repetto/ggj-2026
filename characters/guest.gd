class_name Guest
extends CharacterBody2D


enum GuestState {
	SEEKING_PARTNER,
	GETTING_TO_DANCE_POSITION,
	DANCING,
	FOLLOWING_YOU,
	DEAD,
}


var current_state := GuestState.SEEKING_PARTNER

var _dance_partner: Node2D = null


func is_available() -> bool:
	return current_state == GuestState.SEEKING_PARTNER


func set_partner(dance_partner: Node2D) -> bool:
	if is_instance_valid(dance_partner) and is_available():
		_dance_partner = dance_partner
		current_state = GuestState.GETTING_TO_DANCE_POSITION
		return true
	return false


func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_SPACE):
		current_state = (current_state + 1) % (GuestState.DEAD + 1)
	
	match current_state:
		GuestState.SEEKING_PARTNER:
			print("Hot single 0km near you!")  
		GuestState.GETTING_TO_DANCE_POSITION: 
			print("Scusi, vuol ballare con me~~?")
		GuestState.DANCING:
			print("♪┏(・o･)┛♪")
		GuestState.FOLLOWING_YOU:
			print("Voglio un po' di schewps, solo io e te!")
		GuestState.DEAD:
			print("(×_×)")
