extends CharacterBody2D

@onready var body_sprite : AnimatedSprite2D = $Body
@onready var head_sprite : AnimatedSprite2D = $Head
var speed : float = 300
var knockback_velocity : Vector2 = Vector2.ZERO
var knockback_speed : float = 700
var knockback_deceleration : float = 10

func _physics_process(_delta: float) -> void:
	var animation_to_play : String
	velocity = knockback_velocity + Vector2(Input.get_axis("walk_left", "walk_right"), Input.get_axis("walk_up", "walk_down")).normalized() * speed
	if velocity.x < -1:
		body_sprite.flip_h = true
		head_sprite.flip_h = true
		animation_to_play = "WALK_SIDE"
	if velocity.x > 1:
		body_sprite.flip_h = false
		head_sprite.flip_h = false
		animation_to_play = "WALK_SIDE"
	if velocity == Vector2.ZERO :
		animation_to_play = "IDLE"
	if velocity.y > 1 :
		animation_to_play = "WALK_UP"
	if velocity.y < -1 :
		animation_to_play = "WALK_DOWN"
	body_sprite.play(animation_to_play)
	head_sprite.play(animation_to_play)
	move_and_slide()
	if knockback_velocity.length() > 0:
		knockback_velocity = knockback_velocity.move_toward(Vector2.ZERO, knockback_deceleration)
		print(knockback_velocity)

func knockback(from : Vector2):
	var dir : Vector2 = (position - from).normalized()
	knockback_velocity = dir * knockback_speed
