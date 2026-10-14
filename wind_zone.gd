extends Area2D


@export var wind_force: Vector2 = Vector2(-800.0, 0.0)

func _physics_process(_delta: float) -> void:
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.has_method("apply_force"):
			body.apply_force(wind_force)
		elif body is RigidBody2D:
			body.apply_central_force(wind_force * 3.0)
