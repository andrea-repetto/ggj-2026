class_name GuestManagerClass
extends Node

var guest_book: Dictionary[String, Guest] = {}

var _seeking_queue: Array[Guest] = []


func _ready() -> void:
	Global.guest_added.connect(_on_guest_added)
	Global.guest_removed.connect(_on_guest_removed)
	Global.guest_changed_state.connect(_on_guest_changed_state)
	Global.guests_paired.connect(_on_guests_paired)


func _on_guest_added(guest: Guest):
	guest_book[guest.guest_name] = guest


func _on_guest_removed(guest: Guest):
	guest_book.erase(guest.guest_name)


func _on_guest_changed_state(guest: Guest, new_state: Guest.GuestState):
	if not guest in guest_book:
		return
	
	match new_state:
		Guest.GuestState.SEEKING_PARTNER:
			_seeking_queue.append(guest)
		Guest.GuestState.GETTING_TO_DANCE_POSITION:
			_seeking_queue.erase(guest)
		Guest.GuestState.DANCING:
			pass
		Guest.GuestState.FOLLOWING_YOU:
			pass
		Guest.GuestState.DEAD:
			pass


func _on_guests_paired(first_guest: Guest, second_guest: Guest):
	pass


func _process(delta: float) -> void:
	pass
