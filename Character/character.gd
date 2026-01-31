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
