extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = 400.0
var gravity_direction: float = 1.0

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# justify the direction of gravity
	if Input.is_action_just_pressed("flip_gravity",):
		toggle_gravity()
	if not is_on_floor():
		velocity.y += gravity * gravity_direction * delta
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = -gravity_direction * JUMP_VELOCITY
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		sprite.flip_h = direction <	0
		if sprite.animation != "run":
			sprite.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if sprite.animation != "default":
			sprite.play("default")

	move_and_slide()

func toggle_gravity() -> void:
	gravity_direction *= -1.0
	up_direction = Vector2(0, -gravity_direction)
	velocity.y = -gravity_direction * 120.0
	sprite.flip_v = gravity_direction < 0
