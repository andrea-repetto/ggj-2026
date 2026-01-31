class_name Guest
extends CharacterBody2D


const DISTANCE_THRESHOLD_SQUARED := 10.0 * 10.0


enum GuestState {
	IDLING,
	SEEKING_PARTNER,
	GETTING_TO_DANCE_POSITION,
	DANCING,
	FOLLOWING_YOU,
	DEAD,
}


## Pixel per seconds.
@export_range(0.1, 1.0, 0.1, "or_greater", "hide_slider")
var speed: float = 10.0

var guest_name: String = "Pancrazio Cormorano"

var current_state := GuestState.IDLING
var sought_partner: Guest = null

var _dance_partner: Node2D = null
var _movement_target: Vector2 # Initialized through tapullo.


func is_available() -> bool:
	return current_state == GuestState.SEEKING_PARTNER


func set_partner(dance_partner: Node2D) -> bool:
	if is_instance_valid(dance_partner) and is_available():
		_dance_partner = dance_partner
		current_state = GuestState.GETTING_TO_DANCE_POSITION
		Global.guest_changed_state.emit(self, GuestState.GETTING_TO_DANCE_POSITION)
		return true
	return false


func _init() -> void:
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING


func _ready() -> void:
	var tapullo = func ():
		await get_tree().physics_frame
		_movement_target = position
	tapullo.call_deferred()
	Global.guest_added.emit(self)
	$Timer.start()


func _move_to_random_place() -> void:
	if position.distance_squared_to(_movement_target) < DISTANCE_THRESHOLD_SQUARED:
		_movement_target = \
			NavigationServer2D.region_get_random_point(Global.nav_region_RID, 0, false)


func _process(delta: float) -> void:
	match current_state:
		GuestState.IDLING:
			_move_to_random_place()
		
		GuestState.SEEKING_PARTNER:
			if is_instance_valid(sought_partner):
				_movement_target = sought_partner.position
			else:
				_move_to_random_place()
		
		GuestState.GETTING_TO_DANCE_POSITION: 
			print("Scusi, vuol ballare con me~~?")
		GuestState.DANCING:
			print("♪┏(・o･)┛♪")
		GuestState.FOLLOWING_YOU:
			print("Voglio un po' di schewps, solo io e te!")
		GuestState.DEAD:
			print("(×_×)")


func _physics_process(delta: float) -> void:
	if position.distance_squared_to(_movement_target) > DISTANCE_THRESHOLD_SQUARED:
		velocity = position.direction_to(_movement_target) * speed
		move_and_slide()


func _on_idling_timeout() -> void:
	current_state = GuestState.SEEKING_PARTNER
	Global.guest_changed_state.emit(self, GuestState.SEEKING_PARTNER)
