extends RigidBody2D


var is_in_shadow_world: bool = false

func  _ready() -> void:
	EventBus.world_switched.connect(set_world_mode)

func set_world_mode(in_shadow: bool) -> void:
	is_in_shadow_world = in_shadow
	if is_in_shadow_world:
		gravity_scale = -2.0
	else:
		gravity_scale = 1.5
