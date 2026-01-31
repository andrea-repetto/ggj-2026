class_name GuestManagerClass
extends Node

var guest_book: Dictionary[String, Guest] = {}

var seeking_queue: Array[Guest] = []


func _ready() -> void:
	Global.guest_added.connect(_on_guest_added)
	Global.guest_removed.connect(_on_guest_removed)
	Global.guest_changed_state.connect(_on_guest_changed_state)


func _on_guest_added(guest: Guest):
	guest_book[guest.guest_name] = guest


func _on_guest_removed(guest: Guest):
	guest_book.erase(guest.guest_name)


func _on_guest_changed_state(guest: Guest, new_state: Guest.GuestState):
	if not guest.guest_name in guest_book:
		return
	
	match new_state:
		Guest.GuestState.IDLING:
			pass
		Guest.GuestState.SEEKING_PARTNER:
			seeking_queue.append(guest)
			if seeking_queue.size() > 1:
				var first := seeking_queue.pop_back() as Guest
				var second := seeking_queue.pop_back() as Guest
				first.sought_partner = second
				second.sought_partner = first
		
		Guest.GuestState.GETTING_TO_DANCE_POSITION:
			seeking_queue.erase(guest)
		Guest.GuestState.DANCING:
			pass
		Guest.GuestState.FOLLOWING_YOU:
			pass
		Guest.GuestState.DEAD:
			pass


func _process(delta: float) -> void:
	pass
