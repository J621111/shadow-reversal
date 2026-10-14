extends Node

signal world_switched(is_shadow: bool)

func trigger_world_switch(is_shadow: bool) -> void:
	world_switched.emit(is_shadow)
