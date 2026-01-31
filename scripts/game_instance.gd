class_name GameInstance
extends Node


@export_range(0.1, 1.0, 0.1, "or_greater", "hide_slider")
var max_tension: float = 1.0

var current_tension: float = 0.0
var nav_region_RID: RID


signal guest_added(guest: Guest)
signal guest_removed(guest: Guest)
signal guest_changed_state(guest: Guest, new_state: Guest.GuestState)


func _ready() -> void:
	var nav_regions := get_tree().get_nodes_in_group("nav_region")
	if not nav_regions.is_empty():
		nav_region_RID = nav_regions[0].get_rid()
