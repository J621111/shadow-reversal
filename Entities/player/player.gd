extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = 400.0
var gravity_direction: float = 1.0

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

var external_force: Vector2 = Vector2.ZERO

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
	var target_velocity_x = (direction * SPEED) + external_force.x
	velocity.x = move_toward(velocity.x, target_velocity_x, 1200.0 * delta)
	
	if direction:
		sprite.flip_h = direction <	0
		if sprite.animation != "run":
			sprite.play("run")
	else:
		if sprite.animation != "default":
			sprite.play("default")

	move_and_slide()
	external_force = Vector2.ZERO
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider is RigidBody2D:
			var force_push = 120.0
			var push_direction = -collision.get_normal()
			collider.apply_central_impulse(push_direction * force_push)

func toggle_gravity() -> void:
	gravity_direction *= -1.0
	up_direction = Vector2(0, -gravity_direction)
	velocity.y = -gravity_direction * 120.0
	sprite.flip_v = gravity_direction < 0
	var is_shadow = gravity_direction < 0
	EventBus.trigger_world_switch(is_shadow)
	
func apply_force(force: Vector2) -> void:
	external_force += force
