extends CharacterBody2D
class_name Player

@export var SPEED = 125.0
@export var JUMP_VELOCITY = 200.0
@export var GRAVITY = 400.0
@export var GROUND_FRICTION = 10
@onready var animated_sprite = $AnimatedSprite2D

var active = true

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		if velocity.y > 500:
			velocity.y = 500
	
	var direction = 0
	if active == true:
		if Input.is_action_just_pressed("jump") && is_on_floor():
			jump(JUMP_VELOCITY)
	
		direction = Input.get_axis("move_left", "move_right")
	if direction != 0:
		animated_sprite.flip_h = (direction == -1)

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED/GROUND_FRICTION)
	
	move_and_slide()
	update_animation(direction)

func jump(force):
	AudioPlayer.play_sfx("jump")
	velocity.y = -force

func update_animation(direction):
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		if velocity.y < 0:
			animated_sprite.play("jump")
		else:
			animated_sprite.play("fall")
	
