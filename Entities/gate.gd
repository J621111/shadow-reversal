extends StaticBody2D

@export var open_texture: Texture2D
@export var close_texture: Texture2D

@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var sprite: Sprite2D = $Sprite2D

var is_open: bool = false

func _ready() -> void:
	close()
	
func open() -> void:
	is_open = true
	if open_texture:
		sprite.texture = open_texture
	collision.set_deferred("disabled", true)
	
func close() -> void:
	is_open = false
	if close_texture:
		sprite.texture = close_texture
	collision.set_deferred("disabled", false)
