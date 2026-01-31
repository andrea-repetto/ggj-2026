class_name Character
extends CharacterBody2D


@export_range(1.0, 1.1, 0.1, "or_greater", "hide_slider")
var speed: float = 300.0
@export_range(1.0, 1.1, 0.1, "or_greater", "hide_slider")
var knockback_speed: float = 700.0
@export_range(1.0, 1.1, 0.1, "or_greater", "hide_slider")
var knockback_deceleration: float = 10.0

@onready var body_sprite: AnimatedSprite2D = $Body
@onready var head_sprite: AnimatedSprite2D = $Head
@onready var player_input: PlayerInput = $PlayerInput

var knockback_velocity: Vector2 = Vector2.ZERO
var disabled: bool = false


func _notification(what: int) -> void:
	if what == NOTIFICATION_DISABLED:
		disabled = true
	if what == NOTIFICATION_ENABLED:
		disabled = false


func _physics_process(_delta: float) -> void:
	if disabled:
		return
	
	velocity = knockback_velocity + player_input.direction * speed
	body_sprite.flip_h = player_input.flip_h
	head_sprite.flip_h = player_input.flip_h
	body_sprite.play(player_input.animation_to_play)
	head_sprite.play(player_input.animation_to_play)
	
	move_and_slide()
	
	if knockback_velocity.length() > 0:
		knockback_velocity = knockback_velocity.move_toward(Vector2.ZERO, knockback_deceleration)
		print(knockback_velocity)


func knockback(from : Vector2):
	if disabled:
		return
	var dir: Vector2 = (position - from).normalized()
	knockback_velocity = dir * knockback_speed


func _on_interaction_range_area_entered(area: Area2D) -> void:
	pass
	#if area.get_parent().is_in_group("guest"):
		#var guest := area.get_parent() as Guest
		#if guest.current_state == Guest.GuestState.SEEKING_PARTNER and \
			#Input.is_key_pressed(KEY_0):
			#guest.dance_partner = self
			#guest.sought_partner = null
			#guest.current_state = Guest.GuestState.DANCING
			#Global.guest_changed_state.emit(guest, Guest.GuestState.DANCING)
			#Global.dancing_couple_formed.emit(self, guest)
